default['appdynamics']['dotnet_agent']['version'] = 'latest'
default['appdynamics']['dotnet_agent']['source'] = 'https://packages.appdynamics.com/dotnet'
default['appdynamics']['dotnet_agent']['checksum'] = '63837240238fb5b25f40f27f0e58e3bcd2041d87fe79b8529a34eb2282668d82'
default['appdynamics']['dotnet_agent']['install_dir'] = 'C:\Program Files\Appdynamics'
default['appdynamics']['dotnet_agent']['logfiles_dir'] = 'C:\DotNetAgent\Logs'
default['appdynamics']['dotnet_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['dotnet_agent']['template']['source'] = 'dotnet/setup.config.erb'
default['appdynamics']['dotnet_agent']['instrument_iis'] = false

# Check the bitness of the OS to determine the installer to download and run
if node['kernel']['machine'] != 'x86_64'
  default['appdynamics']['dotnet_agent']['package_file'] = 'dotNetAgentSetup.msi'
else
  default['appdynamics']['dotnet_agent']['package_file'] = 'dotNetAgentSetup64.msi'
end

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
