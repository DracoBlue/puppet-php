# Class: php::fpm::daemon
#
# Install the PHP FPM daemon. See php::fpm::conf for configuring its pools.
#
# Sample Usage:
#  include php::fpm::daemon
#
class php::fpm::daemon (
  $ensure                      = 'present',
  $log_level                   = 'notice',
  $emergency_restart_threshold = '0',
  $emergency_restart_interval  = '0',
  $process_control_timeout     = '0',
  $log_owner                   = 'root',
  $log_group                   = false,
  $log_dir_mode                = '0770',
) inherits ::php::params {

  # Hack-ish to default to user for group too
  $log_group_final = $log_group ? {
    false   => $log_owner,
    default => $log_group,
  }

  php::package::fpm { $fpm_package_name: ensure => $ensure }

  if ( $ensure != 'absent' ) {
    service { $fpm_service_name:
      ensure    => running,
      enable    => true,
      restart   => "service ${fpm_service_name} reload",
      hasstatus => true,
      require => Php::Package::Fpm[$fpm_package_name],
    }

    # When running FastCGI, we don't always use the same user
    file { '/var/log/php-fpm':
      owner   => $log_owner,
      group   => $log_group_final,
      mode    => $log_dir_mode,
      require => Php::Package::Fpm[$fpm_package_name],
    }

    file { "${fpm_conf_dir}/php-fpm.conf":
      notify  => Service[$fpm_service_name],
      content => template('php/fpm/php-fpm.conf.erb'),
      owner   => 'root',
      group   => 'root',
      mode    => 0644,
      require => Php::Package::Fpm[$fpm_package_name],
    }

  }

}

