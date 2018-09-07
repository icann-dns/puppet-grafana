# @summary add ldap configueration support
#
class grafana::ldap (
  String                        $bind_dn,
  Array[String]                 $search_base_dns,
  Array[Stdlib::Host]           $ldap_servers,
  Stdlib::Port                  $port,
  Boolean                       $use_ssl,
  Boolean                       $ssl_skip_verify,
  String                        $search_filter,
  Array[Grafana::Group_mapping] $group_mappings,
  Optional[String]              $bind_password,
  Grafana::Server_attributes    $server_attributes,
) {
  include grafana

  file {'/etc/grafana/ldap.toml':
    ensure  => file,
    owner   => $grafana::user,
    group   => $grafana::group,
    mode    => '0640',
    content => template('grafana/etc/ldap.toml.erb'),
    notify  => Service[$grafana::service_name],
  }
}
