class kibana (
  $ensure            = 'present',
  $git_hash          = $kibana::params::git_hash,
  $git_source        = $kibana::params::git_source,
  $install_dir       = $kibana::params::install_dir,
  $install_dir_mode  = $kibana::params::install_dir_mode,
  $install_dir_owner = $kibana::params::install_dir_owner,
  $install_dir_group = $kibana::params::install_dir_group
) inherits kibana::params {

  include stdlib

  ### Proper resource chaining

  # Install kibana and notify service of any config changes
  class { 'kibana::install': } ->
  class { 'kibana::config': } ~>
  class { 'kibana::service': }

  # Ensure dependencies are installed before service starts
  class { 'kibana::dependencies': } ->
  Class['kibana::service']

  # chain resources properly with anchor pattern
  anchor { 'kibana::begin': } -> Class['kibana::install'] 
  Class['kibana::service'] -> anchor { 'kibana::end': }

}
