package { "nginx":
    ensure => installed
}
service { "nginx":
    require => Package["nginx"],
    ensure => running,
    enable => true
}
file { "/www":
    ensure => "directory"
}
file { "/www/index.html":
    require => File["/www"],
    ensure => "file",
    content => "<!DOCTYPE html>
        <html><body>
        Hello, world.
        "
}
file { "/etc/nginx/sites-available/default":
    require => [
      Package["nginx"],
      File["/www"]
    ],
    ensure => "file",
    content =>
      "server {
        listen 127.0.0.1:8888;
        server_name localhost;
        access_log /var/log/nginx/access.log;

        location / {
        proxy_pass localhost:8080/;
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }

        location ~* ^.+\.(jpg|jpeg|gif|png|ico|css|zip|tgz|gz|rar|bz2|doc|xls|exe|pdf|ppt|txt|tar|wav|bmp|rtf|js)$ {
        root /var/www;
        }
        }

        location /tomcat {
        proxy_pass localhost:8080/;
        proxy_redirect off;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
      }",
    notify => Service["nginx"]
}
