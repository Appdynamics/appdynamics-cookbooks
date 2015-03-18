require 'spec_helper'

describe 'appdynamics::python_agent' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['appdynamics']['app_name'] = 'app-name'
      node.set['appdynamics']['tier_name'] = 'tier-name'
      node.set['appdynamics']['node_name'] = 'node-name'

      node.set['appdynamics']['controller']['host'] = 'controller-host'
      node.set['appdynamics']['controller']['port'] = 1234
    end
  end

  it 'pip installs latest appdynamics' do
    expect(chef_run.converge(described_recipe)).to install_python_pip('appdynamics')
  end

  it 'creates a minimal appdynamics-python.cfg' do
    expect(chef_run.converge(described_recipe)).to render_file(
      "#{chef_run.node['appdynamics']['python_agent']['config_file']}").
      with_content(File.read(fixture_file('python_agent_minimal.cfg')))
  end

  it 'creates a full appdynamics-python.cfg' do
    chef_run.node.set['appdynamics']['controller']['ssl'] = false
    chef_run.node.set['appdynamics']['controller']['user'] = 'controller-user'
    chef_run.node.set['appdynamics']['controller']['accesskey'] = 'controller-accesskey'
    chef_run.node.set['appdynamics']['controller']['http_proxy']['host'] = 'proxy-host'
    chef_run.node.set['appdynamics']['controller']['http_proxy']['port'] = 2345
    chef_run.node.set['appdynamics']['controller']['http_proxy']['user'] = 'proxy-user'
    chef_run.node.set['appdynamics']['controller']['http_proxy']['password_file'] = 'proxy-password-file'

    chef_run.node.set['appdynamics']['python_agent']['debug'] = true
    chef_run.node.set['appdynamics']['python_agent']['dir'] = '/some/path'

    expect(chef_run.converge(described_recipe)).to render_file(
      "#{chef_run.node['appdynamics']['python_agent']['config_file']}").
      with_content(File.read(fixture_file('python_agent_full.cfg')))
  end
end
