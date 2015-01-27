class nginx::ssl {
  exec { 'mkdir -p /nginx/ssl':
    path => ['/bin']
  }

  exec { 'mkdir -p /nginx/ssl/private':
    path => ['/bin'],
    require => Exec['mkdir -p /nginx/ssl']
  }

  exec { 'mkdir -p /nginx/ssl/certs':
    path => ['/bin'],
    require => Exec['mkdir -p /nginx/ssl/private']
  }

  file { '/root/opensslCA.cnf':
    ensure => present,
    content => template('nginx/opensslCA.cnf.erb'),
    require => Exec['mkdir -p /nginx/ssl/certs']
  }

  exec { 'openssl genrsa -out /nginx/ssl/private/nginxCA.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/opensslCA.cnf']
  }

  exec { "openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /nginx/ssl/private/nginxCA.key -out /nginx/ssl/certs/nginxCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /nginx/ssl/private/nginxCA.key 4096']
  }

  exec { 'openssl genrsa -out /nginx/ssl/private/nginx.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -x509 -new -days 3650 -extensions v3_ca -config /root/opensslCA.cnf -key /nginx/ssl/private/nginxCA.key -out /nginx/ssl/certs/nginxCA.crt"]
  }

  file { '/root/openssl.cnf':
    ensure => present,
    content => template('nginx/openssl.cnf.erb'),
    require => Exec['openssl genrsa -out /nginx/ssl/private/nginx.key 4096']
  }

  exec { "openssl req -sha256 -new -config /root/openssl.cnf -key /nginx/ssl/private/nginx.key -out /nginx/ssl/certs/nginx.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => File['/root/openssl.cnf']
  }

  exec { "openssl x509 -req -sha256 -CAcreateserial -days 3650 -extensions v3_req -extfile /root/opensslCA.cnf -in /nginx/ssl/certs/nginx.csr -CA /nginx/ssl/certs/nginxCA.crt -CAkey /nginx/ssl/private/nginxCA.key -out /nginx/ssl/certs/nginx.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -sha256 -new -config /root/openssl.cnf -key /nginx/ssl/private/nginx.key -out /nginx/ssl/certs/nginx.csr"]
  }
}
