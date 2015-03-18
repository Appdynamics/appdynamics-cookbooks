python_pip 'appdynamics' do
  virtualenv node['appdynamics']['python_agent']['virtualenv'] if node['appdynamics']['python_agent']['virtualenv']
  action node['appdynamics']['python_agent']['action']
  version node['appdynamics']['python_agent']['version'] if node['appdynamics']['python_agent']['version'] != 'latest'
  options '--pre' if node['appdynamics']['python_agent']['prerelease']
end

template node['appdynamics']['python_agent']['config_file'] do
  cookbook node['appdynamics']['python_agent']['template']['cookbook']
  source node['appdynamics']['python_agent']['template']['source']
  owner node['appdynamics']['python_agent']['template']['user']
  owner node['appdynamics']['python_agent']['template']['group']
  mode node['appdynamics']['python_agent']['template']['mode']

  variables(
    :app_name => node['appdynamics']['app_name'],
    :tier_name => node['appdynamics']['tier_name'],
    :node_name => node['appdynamics']['node_name'],

    :controller_host => node['appdynamics']['controller']['host'],
    :controller_port => node['appdynamics']['controller']['port'],
    :controller_ssl => node['appdynamics']['controller']['ssl'],
    :controller_user => node['appdynamics']['controller']['user'],
    :controller_accesskey => node['appdynamics']['controller']['accesskey'],

    :http_proxy_host => node['appdynamics']['controller']['http_proxy']['host'],
    :http_proxy_port => node['appdynamics']['controller']['http_proxy']['port'],
    :http_proxy_user => node['appdynamics']['controller']['http_proxy']['user'],
    :http_proxy_password_file => node['appdynamics']['controller']['http_proxy']['password_file'],

    :debug => node['appdynamics']['python_agent']['debug'],
    :dir => node['appdynamics']['python_agent']['dir']
  )
end
