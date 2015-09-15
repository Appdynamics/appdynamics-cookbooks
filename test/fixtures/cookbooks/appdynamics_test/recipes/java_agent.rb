# comments!

group node['appdynamics']['java_agent']['group'] do
  action :create
end

user node['appdynamics']['java_agent']['owner'] do
  gid node['appdynamics']['java_agent']['group']
  home '/'
  action :create
end
