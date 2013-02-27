class kibana::config {
  file { 'kibana_config':
    ensure  => $kibana::ensure,
    path    => "${kibana::install_dir}/KibanaConfig.rb",
    content => template('kibana/opt/kibana/KibanaConfig.rb.erb')
  }
}
