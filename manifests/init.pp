# == Class: kibana_deprecated
#
# This class installs and configures kibana3 (https://www.elastic.co/products/kibana)
#
#
# === Parameters
#
# [*version*]
#   String.  Version of kibana to install
#
# [*base_url*]
#   String.  HTTP path to fetch kibana package from
#   Default: https://download.elasticsearch.org/kibana/kibana
#
# [*ca_cert*]
#   String: Path to ca cert (PEM formatted)
#   Default: undef
#
# [*tmp_dir*]
#   String.  Working dir for caching package
#   Default: /tmp
#
# [*elasticsearch_username*}
#   String. The Elasticsearch user
#   Default: undef
#
# [*elasticsearch_password*]
#   String. The Elasticsearch password
#   Default: undef
#
# [*pid_file*]
#   String. Path to the pid file
#   Defailt: /var/run/kibana.pid
#
# [*install_path*]
#   String.  Location to install kibana
#   Default: /opt
#
# [*port*]
#   Integer.  Port for kibana to listen on
#   Default: 5601
#
# [*bind*]
#   String. IP Address for kibana to listen on
#   Default: 0.0.0.0
#
# [*es_url*]
#   String.  ElasticSearch path to connect to
#   Default: http://localhost:9200
#
# [*es_preserve_host*]
#   Boolean.
#   Default: true
#
# [*kibana_index*]
#   String.  Index to save searches, visualizations, and dashboards
#   Default: .kibana
#
# [*default_app_id*]
#   String.  The default application to load.
#   Default: discover
#
# [*request_timeout*]
#   Integer.  Time in milliseconds to wait for responses from the back end or elasticsearch.
#   Default: 300000
#
# [*ssl_cert_file*]
#   String. Path to ssl key file (PEM formatted).
#   Default: undef
#
# [*ssl_key_file*]
#   String. Path to ssl cert file (PEM formatted).
#   Default: undef
#
# [*shard_timeout*]
#   String.  Time in milliseconds for Elasticsearch to wait for responses from shards.
#   Default: 0
#
# [*legacy_service_mode*]
#   Boolean.
#   Default: false
#
# [*verify_ssl*]
#   Boolean.
#   Default: true
#
# === Examples
#
# * Installation:
#     class { 'kibana': }
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class kibana_deprecated (
  $version                       = $::kibana_deprecated::params::version,
  $base_url                      = $::kibana_deprecated::params::base_url,
  $ca_cert                       = $::kibana_deprecated::params::ca_cert,
  $install_path                  = $::kibana_deprecated::params::install_path,
  $tmp_dir                       = $::kibana_deprecated::params::tmp_dir,
  $port                          = $::kibana_deprecated::params::port,
  $bind                          = $::kibana_deprecated::params::bind,
  $es_url                        = $::kibana_deprecated::params::es_url,
  $es_preserve_host              = $::kibana_deprecated::params::es_preserve_host,
  $kibana_index                  = $::kibana_deprecated::params::kibana_index,
  $elasticsearch_username        = $::kibana_deprecated::params::elasticsearch_username,
  $elasticsearch_password        = $::kibana_deprecated::params::elasticsearch_password,
  $default_app_id                = $::kibana_deprecated::params::default_app_id,
  $pid_file                      = $::kibana_deprecated::params::pid_file,
  $request_timeout               = $::kibana_deprecated::params::request_timeout,
  $shard_timeout                 = $::kibana_deprecated::params::shard_timeout,
  $ssl_cert_file                 = $::kibana_deprecated::params::ssl_cert_file,
  $ssl_key_file                  = $::kibana_deprecated::params::ssl_key_file,
  $verify_ssl                    = $::kibana_deprecated::params::verify_ssl,
) inherits kibana_deprecated::params {

  if !is_integer($port) {
    fail("Class['kibana_deprecated']: port must be an integer.  Received: ${port}")
  }
  if !is_integer($request_timeout) or $request_timeout < 1 {
    fail("Class['kibana_deprecated']: request_timeout must be an integer greater than 0.  Received: ${$request_timeout}")
  }
  if !is_integer($shard_timeout) or $shard_timeout < 0 {
    fail("Class['kibana_deprecated']: shard_timeout must be an integer 0 or greater.  Received: ${$shard_timeout}")
  }
  validate_absolute_path($install_path)
  validate_absolute_path($tmp_dir)
  validate_absolute_path($pid_file)
  validate_bool($es_preserve_host)
  validate_bool($verify_ssl)

  class { '::kibana_deprecated::install': } ->
  class { '::kibana_deprecated::config': } ~>
  class { '::kibana_deprecated::service': }

  Class['kibana_deprecated::install'] ~> Class['kibana_deprecated::service']
}
