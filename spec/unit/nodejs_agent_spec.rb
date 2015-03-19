require 'spec_helper'

describe 'appdynamics::nodejs_agent' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['appdynamics']['app_name'] = 'app-name'
      node.set['appdynamics']['tier_name'] = 'tier-name'
      node.set['appdynamics']['node_name'] = 'node-name'
      node.set['appdynamics']['controller']['host'] = 'controller-host'
      node.set['appdynamics']['controller']['port'] = 1234

      node.set['appdynamics']['nodejs_agent']['path'] = '/some/path/here'
    end.converge(described_recipe)
  end

  it 'npm installs latest appdynamics' do
    expect(chef_run).to install_nodejs_npm('appdynamics')
  end

  it 'creates a minimal appd.js' do
    expect(chef_run).to render_file('/some/path/here/appd.js')
      .with_content(File.read(fixture_file('nodejs_appd_minimal.js')))
  end
end
