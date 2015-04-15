agent = node['appdynamics']['machine_agent']
controller = node['appdynamics']['controller']
http_proxy = node['appdynamics']['http_proxy']

machine_agent_zip = "#{Chef::Config[:file_cache_path]}/AppDynamicsMachineAgent.zip"

package "unzip" if node[:platform_family].include?("debian")

directory agent['install_dir'] do
  owner agent['owner']
  group agent['group']
  mode "0755"
  recursive true
  action :create
end

remote_file machine_agent_zip do
  source agent['source'] % {:version => agent['version']}
  checksum agent['checksum']
  backup false
  mode "0444"
  notifies :run, "execute[unzip-appdynamics-machine-agent]", :immediately
end

execute "unzip-appdynamics-machine-agent" do
  cwd agent['install_dir']
  command "unzip -qqo #{machine_agent_zip}"
  notifies :create, "template[#{agent['init_script']}]", :immediately
end


template "#{agent['install_dir']}/run.sh" do
  source 'machine/run.sh.erb'
  owner agent['owner']
  group agent['group']
  mode "0744"
  variables(
    :java => agent['java'],
    :java_params => agent['java_params'],
    :install_dir => agent['install_dir'],
  )
end

template agent['init_script'] do
  source 'machine/init.d.erb'
  variables(
    :install_dir => agent['install_dir'],
  )
  owner agent['owner']
  group agent['group']
  mode "0744"
  notifies :enable, "service[appdynamics_machine_agent]", :immediately
  notifies :start, "service[appdynamics_machine_agent]", :immediately
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

    :http_proxy_host => http_proxy['host'],
    :http_proxy_port => http_proxy['port'],
    :http_proxy_user => http_proxy['user'],
    :http_proxy_password_file => http_proxy['password_file'],
  )
end

service "appdynamics_machine_agent" do
  supports [:start, :stop, :restart]
  action [:enable, :start]
end
