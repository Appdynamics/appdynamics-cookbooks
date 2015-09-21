default['appdynamics']['dotnet_agent']['version'] = nil
default['appdynamics']['dotnet_agent']['source'] = nil
default['appdynamics']['dotnet_agent']['install_dir'] = 'C:\Program Files\Appdynamics'
default['appdynamics']['dotnet_agent']['logfiles_dir'] = 'C:\DotNetAgent\Logs'
default['appdynamics']['dotnet_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['dotnet_agent']['template']['source'] = 'dotnet/config.erb'
default['appdynamics']['dotnet_agent']['instrument_iis'] = false

# instrumenting windows services and/or standalone apps
# standalone apps must have restart = false because the service resource will fail trying to restart a non-windows service
default['appdynamics']['dotnet_agent']['standalone_apps'] = nil
# example useage
# default['appdynamics']['dotnet_agent']['standalone_apps'] = [
#   {
#     'name' => 'WindowsServiceNameA', 'executable' => 'a.exe', 'tier' => 'TierA', 'commandline' => 'nil', 'restart' => true
#   },
#   {
#     'name' => 'ExecutableNameB', 'executable' => 'b.exe', 'tier' => 'TierB', 'commandline' => '-a -b', 'restart' => false
#   }
# ]
