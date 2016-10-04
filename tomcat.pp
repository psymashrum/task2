package { "tomcat": 
    ensure => installed
}
service { "tomcat":
    require => Package["tomcat"],
    ensure => running,
    enable => true
}

