package { "tomcat": 
    ensure => installed
}
service { "tomcat":
    require => Package["tomcat"],
    ensure => running,
    enable => true
}

file { "/opt/tomcat/conf/server.xml":
  require=> Package["tomcat"],
  content => 
      "
      <Connector address="127.0.0.1" port="8080" protocol="HTTP/1.1" 
      connectionTimeout="20000" 
      redirectPort="8888" />
      }",
  notify => Service["tomcat"]
}
