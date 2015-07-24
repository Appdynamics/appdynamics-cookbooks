default['appdynamics']['dotnet_agent']['version'] = 'latest'
default['appdynamics']['dotnet_agent']['source'] = 'https://packages.appdynamics.com/dotnet'
default['appdynamics']['dotnet_agent']['checksum'] = '63837240238fb5b25f40f27f0e58e3bcd2041d87fe79b8529a34eb2282668d82'
default['appdynamics']['dotnet_agent']['install_dir'] = 'C:\Program Files\Appdynamics'
default['appdynamics']['dotnet_agent']['logfiles_dir'] = 'C:\DotNetAgent\Logs'
default['appdynamics']['dotnet_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['dotnet_agent']['template']['source'] = 'dotnet/setup.config.erb'

# Check the bitness of the OS to determine the installer to download and run
if node['kernel']['machine'] != 'x86_64'
  default['appdynamics']['dotnet_agent']['package_file'] = 'dotNetAgentSetup.msi'
else
  default['appdynamics']['dotnet_agent']['package_file'] = 'dotNetAgentSetup64.msi'
end
