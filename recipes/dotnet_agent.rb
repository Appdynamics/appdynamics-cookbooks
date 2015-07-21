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
  raise "Unsupported OS architecture"
end

# Download the msi file from source
remote_file "#{agent_msi}" do
  source source_path
  checksum agent['checksum']
end

# Environment Validation

# MSDTC Service
service "MSDTC" do
  action [ :enable, :start ]
end

# WMI Service
service "Winmgmt" do
  action [ :enable, :start ]
end

if agent['version'] < '4.1'
  # COM+ Service is not required in 4.1+
  service "COMSysApp" do
    action [ :enable, :start ]
  end
end

# Check whether IIS 7.0+ is installed
# Enable IIS Health Monitoring for the Machine snapshots to return IIS App Pool data
# There is no equivalent available in chef to get the IIS version - so completely using powershell scripts
powershell_script 'check_IIS' do
	code 'Install-WindowsFeature Web-Request-Monitor'
	only_if '[Single]::Parse((get-itemproperty HKLM:\SOFTWARE\Microsoft\InetStp\  | select versionstring).VersionString.Substring(8)) -ge 7.0'
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
windows_package 'Install AppD .NET Agent' do
  source agent_msi
  options "/lv #{install_log_file} AD_SetupFile=#{setup_config} INSTALLDIR=\"#{install_directory}\""
  installer_type :msi
  only_if { File.exists?(agent_msi) }
end
