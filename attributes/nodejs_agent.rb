default['appdynamics']['nodejs_agent']['path'] = nil
default['appdynamics']['nodejs_agent']['action'] = :install
default['appdynamics']['nodejs_agent']['version'] = 'latest'
default['appdynamics']['nodejs_agent']['helper_file'] = 'appd.js'

default['appdynamics']['nodejs_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['nodejs_agent']['template']['source'] = 'nodejs/appd.js.erb'
default['appdynamics']['nodejs_agent']['template']['user'] = 'root'
default['appdynamics']['nodejs_agent']['template']['group'] = 'root'
default['appdynamics']['nodejs_agent']['template']['mode'] = 0644
