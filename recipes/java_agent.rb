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

package 'unzip' if platform_family?('debian')

directory "#{agent['install_dir']}/conf" do
  owner agent['owner']
  group agent['group']
  mode '0755'
  recursive true
  action :create
end

remote_file node['appdynamics']['java_agent']['zip'] do
  source package_source
  checksum agent['checksum']
  backup false
  mode '0444'
  notifies :run, 'execute[unzip-appdynamics-java-agent]', :immediately
end

execute 'unzip-appdynamics-java-agent' do
  cwd agent['install_dir']
  command "unzip -qqo #{node['appdynamics']['java_agent']['zip']}"
  command "chown -R #{agent['owner']}:#{agent['group']} #{agent['install_dir']}"
end

directory agent['install_dir'] do
  owner agent['owner']
  group agent['group']
  mode '0755'
  recursive true
end

template "#{agent['install_dir']}/conf/controller-info.xml" do
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
