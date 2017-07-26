class { 'apache':
  keepalive    =>  'On',
  default_vhost => false,
}

apache::vhost { 'programm1.doag.org':
  servername            => 'programm1.doag.org',
  ip                    => '85.214.231.45',
  port                  => '443',
  ssl                   => true,
  ssl_cert              => '/etc/tls/doag2015.crt',
  ssl_key               => '/etc/tls/doag2014.key',
  ssl_ca                => '/etc/tls/intermediate2015.crt',
  docroot               => '/var/www/html',
  allow_encoded_slashes => 'nodecode',
  # add "X-Forwarded-Proto: https" to all forwarded requests on this SSL port
  request_headers       => [ 'set X-Forwarded-Proto https' ],
  proxy_preserve_host   => 'true',
  proxy_pass_match      => [
    { 'path' => '^/(\w+)/(\d+)/rest/init.json',
      'url'  => 'http://localhost:9051/rest/init/$1/$2',
    },
    { 'path' => '^/(\w+)/(\d+)/rest/image-resources.json',
      'url'  => 'http://localhost:9051/rest/image-resources/$1/$2',
    },
    { 'path'  =>  '^/(\w+)/(\d+)/(.*)',
      'url'   =>  'http://localhost:9051/$3',
    },
    { 'path'          =>  '/auth/',
      'url'           =>  'http://localhost:9041',
      'reverse_urls'  =>  'http://localhost:9041',
    },
  ],
  redirect_source        => ['/auth',  ],
  redirect_dest          => ['/auth/', ],
  # http://stackoverflow.com/questions/32120129/keycloak-is-causing-ie-to-have-an-infinite-loop
  headers               => 'set P3P "CP=\"Potato\""'
}
