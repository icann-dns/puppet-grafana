# Defined type: grafana::settings
define grafana::settings (
  Hash[String, Any, 1] $settings,
  String $section = $title,
) {
  include grafana
  $ini_defaults = {
    path   => $grafana::config::file,
    notify => Service[$grafana::service_name],
  }

  $_settings = delete_undef_values($settings)

  create_ini_settings({ $section => $_settings }, $ini_defaults)
}
