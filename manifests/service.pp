# == Class: kibana_deprecated::service
#
# This class manages the kibana service
#
#
# === Authors
#
# * Justin Lambert <mailto:jlambert@letsevenup.com>
#
class kibana_deprecated::service {

  service { 'kibana':
    ensure   => running,
    enable   => true,
    require  => File['kibana-init-script'],
    provider => $::kibana_deprecated::params::service_provider,
  }
}
