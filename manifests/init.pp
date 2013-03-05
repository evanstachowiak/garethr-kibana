# class: kibana
#
# This installs kibana (a frontend for logstash)
#
# Parameters:
#   [*ensure*]                 - Installs or uninstalls kibana and config (present|absent)
#   [*git_hash*]               - sha of kibana repo to checkout
#   [*git_source*]             - git repo location to checkout source from
#   [*install_dir*]            - root directory to install kibana into
#   [*install_dir_mode*]       - kibana root directory permissions 
#   [*install_dir_owner*]      - kibana root directory owner 
#   [*install_dir_group*]      - kibana root directory group 
#
# Actions:
#
# Requires:
#
# class { 'stdlib:' } http://forge.puppetlabs.com/puppetlabs/stdlib
# class { 'vcsrepo:' } http://forge.puppetlabs.com/puppetlabs/vcsrepo
# class { 'ruby::dev': } http://forge.puppetlabs.com/puppetlabs/ruby
#
# Sample Usage:
#
# class { 'kibana': }
#
class kibana (
  $ensure            = 'present',
  $git_hash          = $kibana::params::git_hash,
  $git_source        = $kibana::params::git_source,
  $install_dir       = $kibana::params::install_dir,
  $install_dir_mode  = $kibana::params::install_dir_mode,
  $install_dir_owner = $kibana::params::install_dir_owner,
  $install_dir_group = $kibana::params::install_dir_group
) inherits kibana::params {

  # Required modules for this class to work
  include stdlib
  include ruby::dev

  ### Proper resource chaining

  # Install kibana and notify service of any config changes
  class { 'kibana::dependencies': } ->
  class { 'kibana::install': } ->
  class { 'kibana::config': } ~>
  class { 'kibana::service': }

  # chain resources properly with anchor pattern
  anchor { 'kibana::begin': } -> Class['kibana::dependencies'] 
  Class['kibana::service'] -> anchor { 'kibana::end': }

}
