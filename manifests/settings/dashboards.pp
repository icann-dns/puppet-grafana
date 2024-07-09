# @summary used to validate dashboard settings
# @param versions_to_keep number of dashboard versions to keep
# @param default_home_dashboard_path override the default dashboard
class grafana::settings::dashboards (
  Integer[1,20]              $versions_to_keep            = 20,
  Optional[Stdlib::Unixpath] $default_home_dashboard_path = undef,
) {
  $settings = {
    'versions_to_keep'            => $versions_to_keep,
    'default_home_dashboard_path' => $default_home_dashboard_path,
  }

  grafana::settings { 'dashboards': settings => $settings }
}
