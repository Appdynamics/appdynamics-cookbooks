appdynamics_php_agent node['appdynamics']['node_name'] do
  version node['appdynamics']['php_agent']['version']
  source node['appdynamics']['php_agent']['source']
  dest node['appdynamics']['php_agent']['dest']

  app_name node['appdynamics']['app_name']
  tier_name node['appdynamics']['tier_name']

  controller_host node['appdynamics']['controller']['host']
  controller_port node['appdynamics']['controller']['port']
  controller_ssl node['appdynamics']['controller']['ssl']
  account node['appdynamics']['controller']['user']
  accesskey node['appdynamics']['controller']['accesskey']

  http_proxy_host node['appdynamics']['http_proxy']['host']
  http_proxy_port node['appdynamics']['http_proxy']['port']
  http_proxy_user node['appdynamics']['http_proxy']['user']
  http_proxy_password_file node['appdynamics']['http_proxy']['password_file']

  dest node['appdynamics']['php_agent']['dest']
  owner node['appdynamics']['php_agent']['owner']
  group node['appdynamics']['php_agent']['group']
  checksum node['appdynamics']['php_agent']['checksum']
end
