class kibana::params {

  case $::operatingsystem {
    /(?i-mx:debian|ubuntu)/: {
      $git_hash          = '09d04ab79032b427cf6e5f771871ffc6a85c3a00'
      $git_source        = 'git://github.com/rashidkpc/Kibana.git'
      $install_dir       = '/opt/kibana'
      $install_dir_mode  = '0775'
      $install_dir_owner = 'root'
      $install_dir_group = 'root'
  }
    default: {
      fail("Unsupported platform: ${::operatingsystem}")
    }
  }
  
}
