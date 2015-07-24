require 'spec_helper'
require 'fauxhai'

describe 'appdynamics::dotnet_agent' do
  context 'win2008r2' do
    before do
      Fauxhai.mock('platform' => 'windows', 'version' => '2008R2')
    end
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['kernel']['os_info']['windows_directory'] = 'c:\windows'
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
      expect(chef_run).to create_directory('c:\\windows\\Temp')
      expect(chef_run).to_not create_directory('c:\\windows\\not_temp')
    end
    it 'enables MSDTC service' do
      expect(chef_run).to enable_service('MSDTC')
      expect(chef_run).to_not enable_service('not_MSDTC')
    end
    it 'enables Winmgmt service' do
      expect(chef_run).to enable_service('Winmgmt')
      expect(chef_run).to_not enable_service('not_Winmgmt')
    end
    it 'does not enable COMSysApp service' do
      expect(chef_run).to_not enable_service('COMSysApp')
    end
    it 'enables COMSysApp service' do
      chef_run.node.set['appdynamics']['dotnet_agent']['version'] = '4.0.8.0'
      chef_run.converge(described_recipe)
      expect(chef_run).to enable_service('COMSysApp')
      expect(chef_run).to_not enable_service('not_COMSysApp')
    end
    it 'creates setup.xml from template' do
      expect(chef_run).to create_template('c:\\windows\\Temp\\setup.xml')
      expect(chef_run).to_not create_template('c:\\windows\\Temp\\not_setup.xml')
    end
    it 'installs windows_feature IIS-RequestMonitor' do
      expect(chef_run).to install_windows_feature('IIS-RequestMonitor')
      expect(chef_run).to_not install_windows_feature('not_IIS-RequestMonitor')
    end
    it 'installs package AppDynamics .NET Agent' do
      expect(chef_run).to install_package('AppDynamics .NET Agent')
      expect(chef_run).to_not install_package('NOT AppDynamics .NET Agent')
    end
    it 'enables AppDynamics.Agent.Coordinator_service' do
      expect(chef_run).to enable_service('AppDynamics.Agent.Coordinator_service')
      expect(chef_run).to_not enable_service('not_AppDynamics.Agent.Coordinator_service')
    end
  end
  context 'win2012r2' do
    before do
      Fauxhai.mock('platform' => 'windows', 'version' => '2012R2')
    end
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.automatic['kernel']['os_info']['windows_directory'] = 'c:\windows'
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
      expect(chef_run).to create_directory('c:\\windows\\Temp')
      expect(chef_run).to_not create_directory('c:\\windows\\not_temp')
    end
    it 'enables MSDTC service' do
      expect(chef_run).to enable_service('MSDTC')
      expect(chef_run).to_not enable_service('not_MSDTC')
    end
    it 'enables Winmgmt service' do
      expect(chef_run).to enable_service('Winmgmt')
      expect(chef_run).to_not enable_service('not_Winmgmt')
    end
    it 'does not enable COMSysApp service' do
      expect(chef_run).to_not enable_service('COMSysApp')
    end
    it 'enables COMSysApp service' do
      chef_run.node.set['appdynamics']['dotnet_agent']['version'] = '4.0.8.0'
      chef_run.converge(described_recipe)
      expect(chef_run).to enable_service('COMSysApp')
      expect(chef_run).to_not enable_service('not_COMSysApp')
    end
    it 'creates setup.xml from template' do
      expect(chef_run).to create_template('c:\\windows\\Temp\\setup.xml')
      expect(chef_run).to_not create_template('c:\\windows\\Temp\\not_setup.xml')
    end
    it 'installs windows_feature IIS-RequestMonitor' do
      expect(chef_run).to install_windows_feature('IIS-RequestMonitor')
      expect(chef_run).to_not install_windows_feature('not_IIS-RequestMonitor')
    end
    it 'installs package AppDynamics .NET Agent' do
      expect(chef_run).to install_package('AppDynamics .NET Agent')
      expect(chef_run).to_not install_package('NOT AppDynamics .NET Agent')
    end
    it 'enables AppDynamics.Agent.Coordinator_service' do
      expect(chef_run).to enable_service('AppDynamics.Agent.Coordinator_service')
      expect(chef_run).to_not enable_service('not_AppDynamics.Agent.Coordinator_service')
    end
  end
end
