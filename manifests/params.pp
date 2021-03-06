class php::params {
  $fpm_package_name = 'php-fpm'

  case $::osfamily {
    'Debian': {
      $php_package_name = 'php5'
      $php_apc_package_name = 'php-apc'
      $common_package_name = 'php5-common'
      $cli_package_name = 'php5-cli'
      $php_conf_dir = '/etc/php5/conf.d'
      $fpm_service_name = 'php5-fpm'
      $fpm_pool_dir = '/etc/php5/fpm/pool.d'
      $fpm_conf_dir = '/etc/php5/fpm'
      $fpm_error_log = '/var/log/php5-fpm.log'
      $fpm_pid = '/var/run/php5-fpm.pid'
      $httpd_package_name = 'apache2'
      $httpd_service_name = 'apache2'
      $httpd_conf_dir = '/etc/apache2/conf.d'
    }
    default: {
      $php_package_name = 'php'
      $php_apc_package_name = 'php-pecl-apc'
      $common_package_name = 'php-common'
      $cli_package_name = 'php-cli'
      $php_conf_dir = '/etc/php.d'
      $fpm_service_name = 'php-fpm'
      if $::operatingsystem == 'Gentoo' {
      	$fpm_pool_dir = '/etc/php/fpm-php5.3/fpm.d'
      	$fpm_conf_dir = '/etc/php/fpm-php5.3'
        $fpm_pid = '/run/php-fpm.pid'
      }
      else
      {
        $fpm_pool_dir = '/etc/php-fpm.d'
        $fpm_conf_dir = '/etc'
        $fpm_pid = '/var/run/php-fpm/php-fpm.pid'
      }
      $fpm_error_log = '/var/log/php-fpm/error.log'
      $httpd_package_name = 'httpd'
      $httpd_service_name = 'httpd'
      $httpd_conf_dir = '/etc/httpd/conf.d'
    }
  }
}
