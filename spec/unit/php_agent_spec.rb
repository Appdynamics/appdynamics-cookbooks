require_relative '../spec_helper'
require_relative '../../libraries/helpers'

describe 'appdynamics::php_agent' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04', step_into: ['appdynamics_php_agent']) do |node|
      node.set['appdynamics'] = {
        app_name: 'app-name',
        tier_name: 'tier-name',
        node_name: 'node-name',

        controller: {
          host: 'controller-host',
          port: 1234,
          account: 'account',
          accesskey: 'accesskey'
        },

        php_agent: {
          version: '4.1.0.5',
          dest: 'dest'
        }
      }
    end.converge(described_recipe)
  end

  it 'calls the appdynamics_php_agent resource' do
    expect(chef_run).to install_appdynamics_php_agent('node-name').with(
      app_name: 'app-name',
      tier_name: 'tier-name',
      node_name: 'node-name',
      version: '4.1.0.5',
      dest: 'dest'
    )
  end

  it 'downloads and extracts the PHP agent with default source' do
    expect(chef_run).to run_appdynamics_extract('node-name :run extract').with(
      basename: 'appdynamics-php-agent-4.1.0.5.tar.bz2',
      source: 'https://packages.appdynamics.com/4.1.0.5/php/appdynamics-php-agent-linux-x64-4.1.0.5.tar.bz2',
      type: :tar_bz2,
      dest: 'dest'
    )
  end

  it 'notifies to run the install script' do
    resource = chef_run.appdynamics_php_agent('node-name').with(
      app_name: 'app-name',
      tier_name: 'tier-name',
      node_name: 'node-name',
      version: '4.1.0.5',
      dest: 'dest'
    )
    expect(resource).to notify('execute[node-name :run install.sh]').to(:run).immediately
  end

  it 'runs the install script with the right arguments' do
    expect(chef_run).to run_execute('node-name :run install.sh').with(
    )
  end
end
