class nginx {
  require nginx::packages
  require nginx::supervisor

  file { '/etc/nginx/conf.d/example_ssl.conf':
    ensure => absent
  }

  file { '/etc/nginx/nginx.conf':
    ensure => present,
    source => 'puppet:///modules/nginx/etc/nginx/nginx.conf',
    mode => 644
  }
}
