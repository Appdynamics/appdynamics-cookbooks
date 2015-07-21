default['appdynamics']['dotnet_agent']['version'] = 'latest'
default['appdynamics']['dotnet_agent']['source'] = 'http://localhost/AppdynamicsInstallers/' #'https://packages.appdynamics.com/machine/%{version}/JavaAppAgent.zip'
default['appdynamics']['dotnet_agent']['checksum'] = '7acb3756147a1d5a13c49b107a890ea56a8eb4099fd793e498e34b6f0b5962dc' #nil
default['appdynamics']['dotnet_agent']['install_dir'] = 'C:\Program Files\Appdynamics'
default['appdynamics']['dotnet_agent']['logfiles_dir'] = 'C:\DotNetAgent\Logs'

default['appdynamics']['dotnet_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['dotnet_agent']['template']['source'] = 'dotnet/setup.config.erb'
