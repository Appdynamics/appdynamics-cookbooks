default['appdynamics']['machine_agent']['version'] = nil
default['appdynamics']['machine_agent']['source'] = nil
default['appdynamics']['machine_agent']['use_bundled_package'] = false
default['appdynamics']['machine_agent']['checksum'] = nil
default['appdynamics']['machine_agent']['install_dir'] = '/opt/appdynamics/machineagent'
default['appdynamics']['machine_agent']['owner'] = 'root'
default['appdynamics']['machine_agent']['group'] = 'root'

default['appdynamics']['machine_agent']['init_script'] = '/etc/init.d/appdynamics_machine_agent'
default['appdynamics']['machine_agent']['pid_dir'] = '/var/run/'
default['appdynamics']['machine_agent']['pid_file'] = '/var/run/appdynamics_machine_agent.pid'

default['appdynamics']['machine_agent']['template']['cookbook'] = 'appdynamics'
default['appdynamics']['machine_agent']['template']['source'] = 'machine/controller-info.xml.erb'

default['appdynamics']['machine_agent']['init']['cookbook'] = 'appdynamics'
default['appdynamics']['machine_agent']['init']['source'] = 'machine/init.d.erb'

default['appdynamics']['machine_agent']['run_sh']['cookbook'] = 'appdynamics'
default['appdynamics']['machine_agent']['run_sh']['source'] = 'machine/run.sh.erb'

default['appdynamics']['machine_agent']['java'] = '/usr/bin/java'
default['appdynamics']['machine_agent']['java_params'] = '-Xmx32m'
