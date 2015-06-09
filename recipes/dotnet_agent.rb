agent = node['appdynamics']['dotnet_agent']
controller = node['appdynamics']['controller']
proxy = node['appdynamics']['http_proxy'] 
bitness = node['kernel']['os_info']['os_architecture']
install_directory = agent['install_dir']
system_directory = node['kernel']['os_info']['windows_directory']

agent_msi = ""
##################################################################################################################################
# The below paths can also be used instead of temp direcotry. But there will be msiexec exceptions if there is space in the path #
# agent_msi_path = "#{Chef::Config[:file_cache_path]"																			 #
# setup_config = "#{Chef::Config[:file_cache_path]}\\setup.xml"																	 #
# install_log_file = "#{Chef::Config[:file_cache_path]}\\DotnetAgentInstall.log"												 #
##################################################################################################################################
agent_msi_path = "#{system_directory}\\Temp"
setup_config = "#{agent_msi_path}\\setup.xml"
install_log_file = "#{agent_msi_path}\\DotnetAgentInstall.log"


# Check the bitness of the OS to determine the installer to download and run
case bitness
when /64/
  agent_msi = "#{agent_msi_path}\\dotNetAgentSetup64.msi"
  source_path = "#{agent['source']}/dotNetAgentSetup64.msi"
when /32/
  agent_msi = "#{agent_msi_path}\\dotNetAgentSetup.msi"
  source_path = "#{agent['source']}/dotNetAgentSetup.msi"
else
  agent_msi = "Unsupported OS bitness"
end

# Download the msi file from source
remote_file "#{agent_msi}" do
  source source_path
  checksum agent['checksum']
end

# Environment Validation
# Comment if you're installing 4.1 -- Matt Jensen to confirm with Sanjay
# Check whether the MSDTC service is up and running 
# if it is not running, start the service
powershell_script 'check_MSDTC' do
  code 'Start-Service MSDTC'
only_if {'(Get-Service MSDTC).status' != "Running" }
end

# Comment if you're installing 4.1 -- Matt Jensen to confirm with Sanjay
# Check whether the WMI service is up and running 
# if it is not running, start the service
powershell_script 'check_WMI' do
  code 'Start-Service Winmgmt'
only_if {'(Get-Service Winmgmt).status' != "Running" }
end

# Comment if you're installing 4.1 -- Matt Jensen to confirm with Sanjay
# Check whether the COM+ service is up and running
# if it is not running, start the service
powershell_script 'check_complus' do
  code 'Start-Service COMSysApp'
only_if {'(Get-Service COMSysApp).status' != "Running" }
end

# Updating the setup config file based on the parameters
template "#{setup_config}" do
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
  )
end


# Installing the agent 
execute "install #{agent_msi}" do
  command "msiexec /i #{agent_msi} /q /norestart /lv #{install_log_file} AD_SetupFile=#{setup_config} INSTALLDIR=\"#{install_directory}\""
only_if { File.exists?(agent_msi) }
end
