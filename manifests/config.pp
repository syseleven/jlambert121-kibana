# == Class: kibana_deprecated::config
#
# This class configures kibana_deprecated.  It should not be directly called.
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class kibana_deprecated::config (
  $install_path           = $::kibana_deprecated::install_path,
  $port                   = $::kibana_deprecated::port,
  $bind                   = $::kibana_deprecated::bind,
  $ca_cert                = $::kibana_deprecated::ca_cert,
  $es_url                 = $::kibana_deprecated::es_url,
  $es_preserve_host       = $::kibana_deprecated::es_preserve_host,
  $kibana_index           = $::kibana_deprecated::kibana_index,
  $elasticsearch_username = $::kibana_deprecated::elasticsearch_username,
  $elasticsearch_password = $::kibana_deprecated::elasticsearch_password,
  $default_app_id         = $::kibana_deprecated::default_app_id,
  $pid_file               = $::kibana_deprecated::pid_file,
  $request_timeout        = $::kibana_deprecated::request_timeout,
  $shard_timeout          = $::kibana_deprecated::shard_timeout,
  $ssl_cert_file          = $::kibana_deprecated::ssl_cert_file,
  $ssl_key_file           = $::kibana_deprecated::ssl_key_file,
  $verify_ssl             = $::kibana_deprecated::verify_ssl,
){

  file { "${install_path}/kibana/config/kibana.yml":
    ensure  => 'file',
    owner   => 'kibana',
    group   => 'kibana',
    mode    => '0440',
    content => template('kibana_deprecated/kibana.yml.erb'),
  }

}
