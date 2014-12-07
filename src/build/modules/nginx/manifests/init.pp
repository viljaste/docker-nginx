class nginx {
  require nginx::packages
  require nginx::supervisor

  exec { 'mkdir -p /nginx/data':
    path => ['/bin']
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => present,
    source => 'puppet:///modules/nginx/etc/nginx/conf.d/default.conf',
    mode => 644
  }
}
