class kibana (
  $ensure            = 'present',
  $git_hash          = $kibana::params::git_hash,
  $install_dir       = $kibana::params::install_dir,
  $install_dir_mode  = $kibana::params::install_dir_mode,
  $install_dir_owner = $kibana::params::install_dir_owner,
  $install_dir_group = $kibana::params::install_dir_group
) inherits kibana::params {
  $ensure_dir = $ensure ? { 'present' => 'directory', default => $ensure }

  File['kibana_install_dir'] ->
  Vcsrepo['/opt/kibana']
  file { 'kibana_install_dir':
    ensure => $ensure_dir,
    path   => $install_dir,
    mode   => $install_dir_mode,
    owner  => $install_owner,
    group  => $install_group,
  }
  vcsrepo { '/opt/kibana':
    ensure   => 'present',
    provider => 'git',
    source   => 'git://github.com/rashidkpc/Kibana.git',
    revision => $git_hash,
  }

  class { 'kibana::config': } ~>
  class { 'kibana::service': }
  anchor { 'kibana::begin': } -> Class ['kibana::params']
  Class['kibana::service'] -> anchor { 'kibana::end': }
}
