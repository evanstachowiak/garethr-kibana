class kibana::dependencies {

  Package {
    ensure => $kibana::ensure,
    provider => gem,
  }
  if ! defined(Package['sinatra'])   { package { 'sinatra': } }
  if ! defined(Package['json'])      { package { 'json': } }
  if ! defined(Package['fastercsv']) { package { 'fastercsv': } }
  if ! defined(Package['daemons'])   { package { 'daemons': } }
  if ! defined(Package['tzinfo'])    { package { 'tzinfo': } }
  if ! defined(Package['thin'])      { package { 'thin': } }

}
