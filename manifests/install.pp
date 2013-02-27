class kibana::install {
  wget::fetch { 'download_kibana':
    source      => 'http://github.com/rashidkpc/Kibana/tarball/kibana-ruby',
    destination => '/usr/local/src/kibana-ruby.tar.gz',
    before      => Exec['untar_kibana'],
  }

  exec { 'untar_kibana':
    command => 'tar xvf /usr/local/src/kibana-ruby.tar.gz',
    cwd     => '/opt',
    creates => "/opt/rashidkpc-Kibana-${kibana::git_hash}",
    path    => '/bin',
    before  => File['/opt/kibana'],
  }

  file { '/opt/kibana':
    ensure => link,
    target => "/opt/rashidkpc-Kibana-${kibana::git_hash}",
    before => Exec['bundle_kibana'],
  }

  exec { 'bundle_kibana':
    command => 'bundle install --path vendor',
    path    => '/bin:/usr/bin:/sbin:/usr/sbin',
    cwd     => '/opt/kibana',
    creates => '/opt/kibana/vendor',
  }
}
