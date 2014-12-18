class nginx {
  if ! file_exists('/nginx/ssl/certs/vhost.crt') {
    require nginx::ssl
  }

  file { '/etc/nginx/conf.d/default.conf':
    ensure => present,
    content => template('nginx/default.conf.erb'),
    mode => 644
  }

  file { '/etc/nginx/conf.d/default-ssl.conf':
    ensure => present,
    content => template('nginx/default-ssl.conf.erb'),
    mode => 644
  }
}
