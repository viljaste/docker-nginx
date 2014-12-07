class nginx {
  require nginx::packages
  require nginx::supervisor

  exec { 'mkdir -p /nginx/data':
    path => ['/bin']
  }

  file { '/etc/nginx/conf.d/example_ssl.conf':
    ensure => absent
  }
}
