default['appdynamics']['python_agent']['virtualenv'] = nil
default['appdynamics']['python_agent']['action'] = :install
default['appdynamics']['python_agent']['version'] = 'latest'
default['appdynamics']['python_agent']['prerelease'] = true
default['appdynamics']['python_agent']['config_file'] = '/etc/appdynamics-python.cfg'

default['appdynamics']['python_agent']['dir'] = nil
default['appdynamics']['python_agent']['debug'] = false

default['appdynamics']['python_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['python_agent']['template']['source'] = 'appdynamics-python.cfg.erb'
default['appdynamics']['python_agent']['template']['user'] = 'root'
default['appdynamics']['python_agent']['template']['group'] = 'root'
default['appdynamics']['python_agent']['template']['mode'] = 0644
