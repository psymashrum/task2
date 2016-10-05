class { 'nginx': }
nginx::resource::vhost { 'localhost': 
  listen_port	=> 8888,
  proxy		=> 'http://localhost:8080',
}
