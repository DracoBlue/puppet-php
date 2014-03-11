define php::package::fpm(
  $ensure = 'present',
) {

  if $caller_module_name != $module_name {
    warning("${name} is deprecated as a public API of the ${module_name} module and should no longer be directly included in the manifest.")
  }

  anchor { 'php::package::fpm::begin': }
  anchor { 'php::package::fpm::end': }

  case $::osfamily {
    'debian': {
      $package_name = 'php5-fpm'

      package { 'php::package::fpm::debian':
        package_name   => $package_name,
        ensure => $ensure,
        require        => Anchor['php::package::fpm::begin'],
        before         => Anchor['php::package::fpm::end'],
      }
    }
    default: {
      case $::operatingsystem {
	'Gentoo': {
        }
        default: {
          $package_name = 'php-fpm'

      	  package { 'php::package::fpm::default':
            package_name   => $package_name,
            ensure => $ensure,
            require        => Anchor['php::package::fpm::begin'],
            before         => Anchor['php::package::fpm::end'],
          }
        }
      }
    }
  }
}
