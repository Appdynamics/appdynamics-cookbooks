case node['platform_family']
when 'debian', 'rhel', 'fedora'
  default['test-helper']['node_attributes_path'] = '/tmp/serverspec/'
when 'windows'
  default['test-helper']['node_attributes_path'] = "#{node['kernel']['os_info']['system_drive']}\\windows\\temp\\serverspec\\"
else
  Chef::Log.error("test-helper is not supported on #{node['platform_family']}")
end
