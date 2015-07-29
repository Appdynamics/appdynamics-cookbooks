require 'spec_helper'
require 'fauxhai'

describe 'appdynamics::dotnet_agent' do
  context 'win2008r2' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2008R2') do |node|
        node.automatic['kernel']['machine'] = 'x86_64'
        node.set['appdynamics']['dotnet_agent']['template']['cookbook'] = 'appdynamics'
        node.set['appdynamics']['dotnet_agent']['template']['source'] = 'dotnet/setup.config.erb'
        node.set['appdynamics']['app_name'] = 'myapp'
        node.set['appdynamics']['controller']['host'] = 'appdynamics-controller.domain.com'
        node.set['appdynamics']['controller']['port'] = '443'
        node.set['appdynamics']['controller']['user'] = 'someuser'
        node.set['appdynamics']['controller']['accesskey'] = 'supersecret'
        node.set['appdynamics']['http_proxy']['host'] = 'appdynamics-proxy.domain.com'
        node.set['appdynamics']['http_proxy']['port'] = '80'
        node.set['appdynamics']['install_dir'] = 'C:\Program Files\Appdynamics'
      end.converge(described_recipe)
    end
    it 'creates a temp directory' do
      expect(chef_run).to create_directory('temp')
    end
    it 'enables MSDTC service' do
      expect(chef_run).to enable_service('MSDTC')
      expect(chef_run).to start_service('MSDTC')
    end
    it 'enables Winmgmt service' do
      expect(chef_run).to enable_service('Winmgmt')
      expect(chef_run).to start_service('Winmgmt')
    end
    it 'does not enable COMSysApp service' do
      expect(chef_run).to_not enable_service('COMSysApp')
      expect(chef_run).to_not start_service('COMSysApp')
    end
    it 'enables COMSysApp service' do
      chef_run.node.set['appdynamics']['dotnet_agent']['version'] = '4.0.8.0'
      chef_run.converge(described_recipe)
      expect(chef_run).to enable_service('COMSysApp')
      expect(chef_run).to start_service('COMSysApp')
    end
    it 'creates setup.xml from template' do
      expect(chef_run).to create_template('C:\Windows\Temp\setup.xml')
    end
    it 'installs windows_feature IIS-RequestMonitor' do
      expect(chef_run).to install_windows_feature('IIS-RequestMonitor')
    end
    it 'installs package AppDynamics .NET Agent' do
      expect(chef_run).to install_package('AppDynamics .NET Agent')
    end
    it 'enables AppDynamics.Agent.Coordinator_service' do
      expect(chef_run).to enable_service('AppDynamics.Agent.Coordinator_service')
      expect(chef_run).to start_service('AppDynamics.Agent.Coordinator_service')
    end
    it 'template C:\Windows\Temp\setup.xml to notify AppDynamics.Agent.Coordinator_service' do
      expect(chef_run.template('C:\Windows\Temp\setup.xml')).to notify('windows_service[AppDynamics.Agent.Coordinator_service]').to(:restart).delayed
    end
    it 'powershell_script Restart IIS does not subscribe AppDynamics.Agent.Coordinator_service' do
      expect(chef_run.powershell_script('Restart IIS')).to_not subscribe_to('service[AppDynamics.Agent.Coordinator_service]')
    end
    it 'powershell_script Restart IIS subscribes to AppDynamics.Agent.Coordinator_service' do
      chef_run.node.set['appdynamics']['dotnet_agent']['instrument_iis'] = true
      chef_run.converge(described_recipe)
      expect(chef_run.powershell_script('Restart IIS')).to subscribe_to('service[AppDynamics.Agent.Coordinator_service]').delayed
    end
    it 'powershell_script Restart IIS does nothing' do
      chef_run.node.set['appdynamics']['dotnet_agent']['instrument_iis'] = true
      chef_run.converge(described_recipe)
      expect(chef_run).to_not run_powershell_script('Restart IIS')
    end
  end
  context 'win2012r2' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'windows', version: '2012R2') do |node|
        node.automatic['kernel']['machine'] = 'x86_64'
        node.set['appdynamics']['dotnet_agent']['template']['cookbook'] = 'appdynamics'
        node.set['appdynamics']['dotnet_agent']['template']['source'] = 'dotnet/setup.config.erb'
        node.set['appdynamics']['app_name'] = 'myapp'
        node.set['appdynamics']['controller']['host'] = 'appdynamics-controller.domain.com'
        node.set['appdynamics']['controller']['port'] = '443'
        node.set['appdynamics']['controller']['user'] = 'someuser'
        node.set['appdynamics']['controller']['accesskey'] = 'supersecret'
        node.set['appdynamics']['http_proxy']['host'] = 'appdynamics-proxy.domain.com'
        node.set['appdynamics']['http_proxy']['port'] = '80'
        node.set['appdynamics']['install_dir'] = 'C:\Program Files\Appdynamics'
      end.converge(described_recipe)
    end
    it 'creates a temp directory' do
      expect(chef_run).to create_directory('temp')
    end
    it 'enables MSDTC service' do
      expect(chef_run).to enable_service('MSDTC')
      expect(chef_run).to start_service('MSDTC')
    end
    it 'enables Winmgmt service' do
      expect(chef_run).to enable_service('Winmgmt')
      expect(chef_run).to start_service('Winmgmt')
    end
    it 'does not enable COMSysApp service' do
      expect(chef_run).to_not enable_service('COMSysApp')
      expect(chef_run).to_not start_service('COMSysApp')
    end
    it 'enables COMSysApp service' do
      chef_run.node.set['appdynamics']['dotnet_agent']['version'] = '4.0.8.0'
      chef_run.converge(described_recipe)
      expect(chef_run).to enable_service('COMSysApp')
      expect(chef_run).to start_service('COMSysApp')
    end
    it 'creates setup.xml from template' do
      expect(chef_run).to create_template('C:\Windows\Temp\setup.xml')
    end
    it 'installs windows_feature IIS-RequestMonitor' do
      expect(chef_run).to install_windows_feature('IIS-RequestMonitor')
    end
    it 'installs package AppDynamics .NET Agent' do
      expect(chef_run).to install_package('AppDynamics .NET Agent')
    end
    it 'enables AppDynamics.Agent.Coordinator_service' do
      expect(chef_run).to enable_service('AppDynamics.Agent.Coordinator_service')
      expect(chef_run).to start_service('AppDynamics.Agent.Coordinator_service')
    end
    it 'template C:\Windows\Temp\setup.xml to notify AppDynamics.Agent.Coordinator_service' do
      expect(chef_run.template('C:\Windows\Temp\setup.xml')).to notify('windows_service[AppDynamics.Agent.Coordinator_service]').to(:restart).delayed
    end
    it 'powershell_script Restart IIS does not subscribe AppDynamics.Agent.Coordinator_service' do
      expect(chef_run.powershell_script('Restart IIS')).to_not subscribe_to('service[AppDynamics.Agent.Coordinator_service]')
    end
    it 'powershell_script Restart IIS subscribes to AppDynamics.Agent.Coordinator_service' do
      chef_run.node.set['appdynamics']['dotnet_agent']['instrument_iis'] = true
      chef_run.converge(described_recipe)
      expect(chef_run.powershell_script('Restart IIS')).to subscribe_to('service[AppDynamics.Agent.Coordinator_service]').delayed
    end
    it 'powershell_script Restart IIS does nothing' do
      chef_run.node.set['appdynamics']['dotnet_agent']['instrument_iis'] = true
      chef_run.converge(described_recipe)
      expect(chef_run).to_not run_powershell_script('Restart IIS')
    end
  end
end
