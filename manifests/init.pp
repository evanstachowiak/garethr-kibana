class kibana(
  $git_hash = 'edb4553',
){
  class { 'kibana::install': } ->
  class { 'kibana::config': } ~>
  class { 'kibana::service': }

  anchor { 'kibana::begin': } -> Class ['kibana::install']
  Class['kibana::service'] -> anchor { 'kibana::end': }
}
