require 'pathname'

agent = node['appdynamics']['nodejs_agent']
controller = node['appdynamics']['controller']
http_proxy = node['appdynamics']['http_proxy']

nodejs_npm 'appdynamics' do
  path agent['path'] if agent['path']
  version agent['version'] unless agent['version'] == 'latest'
  user agent['install_user'] if agent['install_user']
  group agent['install_group'] if agent['install_group']
end

if agent['helper_file']
  pathname = Pathname(agent['helper_file'])

  if pathname.relative?
    unless agent['path']
      Chef::Log.warning "Skipping #{agent['helper_file']} because it is relative but node['appdynamics']['nodejs_agent']['path'] is empty."
      return
    end

    pathname = Pathname(agent['path']).join(pathname)
  end

  template pathname.to_s do
    cookbook agent['template']['cookbook']
    source agent['template']['source']
    owner agent['template']['user']
    owner agent['template']['group']
    mode agent['template']['mode']

    variables(
      :app_name => node['appdynamics']['app_name'],
      :tier_name => node['appdynamics']['tier_name'],
      :node_name => node['appdynamics']['node_name'],

      :controller_host => controller['host'],
      :controller_port => controller['port'],
      :controller_ssl => controller['ssl'],
      :controller_user => controller['user'],
      :controller_accesskey => controller['accesskey'],

      :http_proxy_host => http_proxy['host'],
      :http_proxy_port => http_proxy['port'],
      :http_proxy_user => http_proxy['user'],
      :http_proxy_password_file => http_proxy['password_file'],
    )
  end
end
