default['appdynamics']['java_agent']['version'] = nil
default['appdynamics']['java_agent']['source'] = nil
default['appdynamics']['java_agent']['ibm_jvm'] = false
default['appdynamics']['java_agent']['checksum'] = nil
default['appdynamics']['java_agent']['install_dir'] = '/opt/appdynamics/javaagent'
default['appdynamics']['java_agent']['owner'] = 'root'
default['appdynamics']['java_agent']['group'] = 'root'

default['appdynamics']['java_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['java_agent']['template']['source'] = 'java/controller-info.xml.erb'

default['appdynamics']['java_agent']['java'] = '/usr/bin/java'
default['appdynamics']['java_agent']['java_params'] = '-Xmx32m'
default['appdynamics']['java_agent']['zip'] = "#{Chef::Config[:file_cache_path]}/AppDynamicsJavaAgent.zip"
