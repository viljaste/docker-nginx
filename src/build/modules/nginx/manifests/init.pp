class nginx {
  require nginx::packages
  require nginx::supervisor

  exec { 'mkdir -p /nginx/data':
    path => ['/bin']
  }

  file { '/etc/nginx/conf.d/example_ssl.conf':
    ensure => absent
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => present,
    source => 'puppet:///modules/nginx/etc/nginx/conf.d/default.conf',
    mode => 644
  }

  file { '/etc/nginx/conf.d/default-ssl.conf':
    ensure => present,
    source => 'puppet:///modules/nginx/etc/nginx/conf.d/default-ssl.conf',
    mode => 644
  }

  file { '/etc/nginx/nginx.conf':
    ensure => present,
    source => 'puppet:///modules/nginx/etc/nginx/nginx.conf',
    mode => 644
  }
}
