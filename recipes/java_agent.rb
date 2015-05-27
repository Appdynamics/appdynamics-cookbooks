agent = node['appdynamics']['java_agent']
controller = node['appdynamics']['controller']
agent_zip = node['appdynamics']['agent_zip']

package "unzip" if node[:platform_family].include?("debian")

directory "#{agent['install_dir']}/conf" do
  owner agent['owner']
  group agent['group']
  mode "0755"
  recursive true
  action :create
end

remote_file agent_zip do
  source agent['source'] % {:version => agent['version']}
  checksum agent['checksum']
  backup false
  mode "0444"
  notifies :run, "execute[unzip-appdynamics-java-agent]", :immediately
end

execute "unzip-appdynamics-java-agent" do
  cwd agent['install_dir']
  command "unzip -qqo #{agent_zip}"
end

template "#{agent['install_dir']}/conf/controller-info.xml" do
  cookbook agent['template']['cookbook']
  source agent['template']['source']
  owner agent['owner']
  group agent['group']
  mode "0600"

  variables(
    :app_name => node['appdynamics']['app_name'],
    :tier_name => node['appdynamics']['tier_name'],
    :node_name => node['appdynamics']['node_name'],

    :controller_host => controller['host'],
    :controller_port => controller['port'],
    :controller_ssl => controller['ssl'],
    :controller_user => controller['user'],
    :controller_accesskey => controller['accesskey'],
  )
end
