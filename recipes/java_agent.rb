include_recipe 'ark'

agent = node['appdynamics']['java_agent']
controller = node['appdynamics']['controller']

version = agent['version'] || node['appdynamics']['version']
fail 'You must specify either node[\'appdynamics\'][\'version\'] or node[\'appdynamics\'][\'dotnet_agent\'][\'version\']' unless version

package_source = agent['source']
unless package_source
  package_source = "#{node['appdynamics']['packages_site']}/java/#{version}/AppServerAgent-"
  package_source << 'ibm-' if agent['ibm_jvm']
  package_source << "#{version}.zip"
end

remote_file node['appdynamics']['java_agent']['zip'] do
  source package_source
  checksum agent['checksum']
  backup false
  mode '0444'
end

ark 'javaagent' do
  url "file:///#{node['appdynamics']['java_agent']['zip']}"
  path agent['install_dir']
  owner agent['owner']
  action :put
end

template "#{agent['install_dir']}/javaagent/conf/controller-info.xml" do
  cookbook agent['template']['cookbook']
  source agent['template']['source']
  owner agent['owner']
  group agent['group']
  mode '0600'

  variables(
    :app_name => node['appdynamics']['app_name'],
    :tier_name => node['appdynamics']['tier_name'],
    :node_name => node['appdynamics']['node_name'],

    :controller_host => controller['host'],
    :controller_port => controller['port'],
    :controller_ssl => controller['ssl'],
    :controller_user => controller['user'],
    :controller_accesskey => controller['accesskey']
  )
end
