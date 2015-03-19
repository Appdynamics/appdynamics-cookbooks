require 'spec_helper'

describe 'appdynamics::python_agent' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      appd = node.set['appdynamics']
      appd['app_name'] = 'app-name'
      appd['tier_name'] = 'tier-name'
      appd['node_name'] = 'node-name'

      appd['controller']['host'] = 'controller-host'
      appd['controller']['port'] = 1234
    end.converge(described_recipe)
  end

  it 'pip installs latest appdynamics' do
    expect(chef_run).to install_python_pip('appdynamics')
  end

  it 'creates a minimal appdynamics-python.cfg' do
    expect(chef_run).to render_file(chef_run.node['appdynamics']['python_agent']['config_file'])
      .with_content(File.read(fixture_file('python_agent_minimal.cfg')))
  end

  it 'creates a full appdynamics-python.cfg' do
    appd = chef_run.node.set['appdynamics']
    appd['controller']['ssl'] = false
    appd['controller']['user'] = 'controller-user'
    appd['controller']['accesskey'] = 'controller-accesskey'
    appd['http_proxy']['host'] = 'proxy-host'
    appd['http_proxy']['port'] = 2345
    appd['http_proxy']['user'] = 'proxy-user'
    appd['http_proxy']['password_file'] = 'proxy-password-file'

    appd['python_agent']['debug'] = true
    appd['python_agent']['dir'] = '/some/path'

    chef_run.converge(described_recipe)

    expect(chef_run).to render_file(chef_run.node['appdynamics']['python_agent']['config_file'])
      .with_content(File.read(fixture_file('python_agent_full.cfg')))
  end
end
