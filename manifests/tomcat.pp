class { 'java': }

tomcat::install { '/opt/tomcat8':
  source_url => 'https://www.apache.org/dist/tomcat/tomcat-8/v8.0.33/bin/apache-tomcat-8.0.33.tar.gz'
}
tomcat::instance { 'tomcat8':
  catalina_home => '/opt/tomcat8',
  catalina_base => '/opt/tomcat8',
}
tomcat::config::server::connector { 'tomcat8':
  catalina_base         => '/opt/tomcat8',
  port                  => '8080',
  protocol              => 'HTTP/1.1',
  additional_attributes => {
    'redirectPort' => '8443'
  },
}
tomcat::config::server { 'tomcat8':
  address		=> '127.0.0.1',
}
