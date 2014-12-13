class nginx::ssl {
  exec { 'openssl genrsa -out /root/nginxCA.key 4096':
    timeout => 0,
    path => ['/usr/bin']
  }

  $subj = "/C=/ST=/L=/O=/CN=$server_name"

  exec { "openssl req -x509 -new -nodes -key /root/nginxCA.key -days 365 -subj $subj -out /root/nginxCA.crt":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /root/nginxCA.key 4096']
  }

  exec { 'openssl genrsa -out /root/nginx.key 4096':
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -x509 -new -nodes -key /root/nginxCA.key -days 365 -subj $subj -out /root/nginxCA.crt"]
  }

  exec { "openssl req -new -key /root/nginx.key -subj $subj -out /root/nginx.csr":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec['openssl genrsa -out /root/nginx.key 4096']
  }

  exec { "openssl x509 -req -in /root/nginx.csr -CA /root/nginxCA.crt -CAkey /root/nginxCA.key -CAcreateserial -out /root/nginx.crt -days 365":
    timeout => 0,
    path => ['/usr/bin'],
    require => Exec["openssl req -new -key /root/nginx.key -subj $subj -out /root/nginx.csr"]
  }

  exec { 'cp /root/nginx.crt /etc/ssl/certs/nginx.crt':
    path => ['/bin'],
    require => Exec["openssl x509 -req -in /root/nginx.csr -CA /root/nginxCA.crt -CAkey /root/nginxCA.key -CAcreateserial -out /root/nginx.crt -days 365"]
  }

  exec { 'cp /root/nginx.key /etc/ssl/private/nginx.key':
    path => ['/bin'],
    require => Exec["openssl x509 -req -in /root/nginx.csr -CA /root/nginxCA.crt -CAkey /root/nginxCA.key -CAcreateserial -out /root/nginx.crt -days 365"]
  }
}
