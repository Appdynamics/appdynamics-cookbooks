agent = node['appdynamics']['dotnet_agent']
controller = node['appdynamics']['controller']
proxy = node['appdynamics']['http_proxy']

version = agent['version'] || node['appdynamics']['version']
fail 'You must specify either node[\'appdynamics\'][\'version\'] or node[\'appdynamics\'][\'dotnet_agent\'][\'version\']' unless version

install_directory = agent['install_dir']
temp_path = "#{node['kernel']['os_info']['windows_directory']}\\Temp"
setup_config = "#{temp_path}\\setup.xml"
install_log_file = "#{temp_path}\\DotnetAgentInstall.log"

package_source = agent['source']
unless package_source
  package_source = "#{node['appdynamics']['packages_site']}/dotnet/#{version}/dotNetAgentSetup"
  package_source << '64' if node['kernel']['machine'] == 'x86_64'
  package_source << "-#{version}.msi"
end

# create directory if it doesn't exist
directory 'temp' do
  path temp_path
end

# MSDTC Service
service 'MSDTC' do
  action [:enable, :start]
end

# WMI Service
service 'Winmgmt' do
  action [:enable, :start]
end

# COM+ Service is not required in 4.1+
service 'COMSysApp' do
  action [:enable, :start]
  only_if { version < '4.1' }
end

windows_feature 'IIS-RequestMonitor' do
  action :install
end

# Updating the setup config file based on the parameters
template setup_config do
  cookbook agent['template']['cookbook']
  source agent['template']['source']
  variables(
    :app_name => node['appdynamics']['app_name'],
    :log_file_directory => agent['logfiles_dir'],
    :controller_host => controller['host'],
    :controller_port => controller['port'],
    :controller_ssl => controller['ssl'],
    :controller_user => controller['user'],
    :controller_accesskey => controller['accesskey'],
    :proxy_host => proxy['host'],
    :proxy_port => proxy['port'],
    :instrument_iis => agent['instrument_iis'],
    :standalone_apps => agent['standalone_apps']
  )
  notifies :restart, 'service[AppDynamics.Agent.Coordinator_service]', :delayed
end

# Installing the agent
package 'AppDynamics .NET Agent' do
  source package_source
  options "/l*v \"#{install_log_file}\" AD_SetupFile=\"#{setup_config}\" INSTALLDIR=\"#{install_directory}\""
end

service 'AppDynamics.Agent.Coordinator_service' do
  action [:enable, :start]
end

if agent['standalone_apps']
  agent['standalone_apps'].each do |apps|
    service apps['name'] do # ~FC022
      action :nothing
      subscribes :restart, 'service[AppDynamics.Agent.Coordinator_service]', :delayed
      subscribes :restart, 'package[AppDynamics .NET Agent]', :delayed
      only_if { apps['restart'] == true }
    end
  end
else
  Chef::Log.info('standalone_apps is nil not restarting any services.')
end

if agent['instrument_iis'] == true
  powershell_script 'Restart IIS' do
    code <<-EOH
    IISReset
    EOH
    action :nothing
    subscribes :run, 'service[AppDynamics.Agent.Coordinator_service]', :delayed
    subscribes :run, 'package[AppDynamics .NET Agent]', :delayed
  end
else
  Chef::Log.warn('Not performing IISReset because instrument_iis does not equal true.')
end
