require 'spec_helper'

describe 'appdynamics::python_agent' do
  let(:chef_run) { ChefSpec::SoloRunner.converge(described_recipe) }

  it 'pip installs latest appdynamics' do
    expect(chef_run).to install_python_pip('appdynamics')
  end

  it 'creates appdynamics-python.cfg' do
    expect(chef_run).to render_file("#{chef_run.node['appdynamics']['python_agent']['config_file']}")
  end
end
