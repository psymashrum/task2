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
  notify => Service["tomcat"]
}
