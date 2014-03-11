define php::package::common(
  $ensure = 'present',
) {

  if $caller_module_name != $module_name {
    warning("${name} is deprecated as a public API of the ${module_name} module and should no longer be directly included in the manifest.")
  }

  anchor { 'php::package::common::begin': }
  anchor { 'php::package::common::end': }

  case $::osfamily {
    'debian': {
      package { 'php::package::common::debian':
        package_name   => 'php5-common',
        ensure => $ensure,
        require        => Anchor['php::package::common::begin'],
        before         => Anchor['php::package::common::end'],
      }
    }
    default: {
      case $::operatingsystem {
	'Gentoo': {
        }
        default: {
      	  package { 'php::package::common::default':
            package_name   => 'php-common',
            ensure => $ensure,
            require        => Anchor['php::package::common::begin'],
            before         => Anchor['php::package::common::end'],
          }
        }
      }
    }
  }
}
