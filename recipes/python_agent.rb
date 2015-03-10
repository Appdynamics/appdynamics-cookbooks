python_pip 'appdynamics' do
    if node['appdynamics']['python_agent']['virtualenv']
        virtualenv node['appdynamics']['python_agent']['virtualenv']
    end
    action node['appdynamics']['python_agent']['action']
    if !node['appdynamics']['python_agent']['version'].starts_with?('latest')
        version node['appdynamics']['python_agent']['version']
    end
    if node['appdynamics']['python_agent']['prerelease']
        options "--pre"
    end
end
