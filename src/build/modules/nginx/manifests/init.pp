class nginx {
  require nginx::packages
  require nginx::supervisor

  exec { 'mkdir -p /nginx/data':
    path => ['/bin']
  }
}
