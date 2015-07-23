agent = node['appdynamics']['dotnet_agent']
controller = node['appdynamics']['controller']
proxy = node['appdynamics']['http_proxy']
install_directory = agent['install_dir']
system_directory = node['kernel']['os_info']['windows_directory']

agent_msi_path = "#{system_directory}\\Temp"
setup_config = "#{agent_msi_path}\\setup.xml"
install_log_file = "#{agent_msi_path}\\DotnetAgentInstall.log"

# Check the bitness of the OS to determine the installer to download and run
case node['kernel']['os_info']['os_architecture']
when /64/
  agent_msi = "#{agent_msi_path}\\dotNetAgentSetup64.msi"
  source_path = "#{agent['source']}/dotNetAgentSetup64.msi"
when /32/
  agent_msi = "#{agent_msi_path}\\dotNetAgentSetup.msi"
  source_path = "#{agent['source']}/dotNetAgentSetup.msi"
else
  raise 'Unsupported OS architecture'
end

# create directory if it doesn't exist
directory 'temp' do
  path agent_msi_path
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
  only_if { agent['version'] < '4.1' }
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
    :proxy_port => proxy['port']
  )
end

# Download the msi file from source
remote_file agent_msi do
  source source_path
  notifies :install, 'package[AppDynamics .NET Agent]', :immediately
end

# Installing the agent
package 'AppDynamics .NET Agent' do
  source agent_msi
  options "/l*v \"#{install_log_file}\" AD_SetupFile=\"#{setup_config}\" INSTALLDIR=\"#{install_directory}\""
end

service 'AppDynamics.Agent.Coordinator_service' do
  action [:enable, :start]
  subscribes :restart, 'template[setup_config]', :delayed
end
