require 'spec_helper'
require 'fauxhai'

describe 'appdynamics::dotnet_agent' do
  context 'win2008r2' do
    before { Fauxhai.mock('platform' => 'windows', 'version' => '2008R2') }
    let(:chef_run) do
      ChefSpec::SoloRunner.new do |node|
        node.set['appdynamics']['dotnet_agent']['template']['cookbook'] = 'appdynamics'
        node.set['appdynamics']['dotnet_agent']['template']['source'] = 'dotnet/setup.config.erb'
        node.set['appdynamics']['dotnet_agent']['version'] = '4.0.7.0'
        node.set['appdynamics']['dotnet_agent']['checksum'] = '7acb3756147a1d5a13c49b107a890ea56a8eb4099fd793e498e34b6f0b5962dc'
        node.set['appdynamics']['logfiles_dir'] = 'C:\DotNetAgent\Logs'
        node.set['appdynamics']['app_name'] = 'myapp'
        node.set['appdynamics']['controller']['host'] = 'appdynamics-controller.domain.com'
        node.set['appdynamics']['controller']['port'] = '443'
        node.set['appdynamics']['controller']['ssl'] = 'true'
        node.set['appdynamics']['controller']['user'] = 'someuser'
        node.set['appdynamics']['controller']['accesskey'] = 'supersecret'
        node.set['appdynamics']['http_proxy']['host'] = 'appdynamics-proxy.domain.com'
        node.set['appdynamics']['http_proxy']['port'] = '80'
        node.set['appdynamics']['install_dir'] = 'C:\Program Files\Appdynamics'
        node.set['appdynamics']['dotnet_agent']['source'] = 'https://download.appdynamics.com/onpremise/public/archives/'
      end.converge(described_recipe)
      it 'creates a temp directory' do
        expect(chef_run).to create_directory('c:\windows\temp')
      end
      it 'creates a remote_file with attributes' do
        expect(chef_run).to create_remote_file('c:\\windows\\Temp\\dotNetAgentSetup64.msi')
        expect(chef_run).to_not create_remote_file('c:\\windows\\Temp\\dotNetAgentSetup.msi')
      end
      it 'enables MSDTC service' do
        expect(chef_run).to enable_service('MSDTC')
        expect(chef_run).to_not enable_service('not_MSDTC')
      end
      it 'enables Winmgmt service' do
        expect(chef_run).to enable_service('Winmgmt')
        expect(chef_run).to_not enable_service('not_Winmgmt')
      end
      it 'enables COMSysApp service' do
        expect(chef_run).to enable_service('COMSysApp')
        expect(chef_run).to_not enable_service('not_COMSysApp')
      end
      it 'creates setup.xml from template' do
        expect(chef_run).to create_template('c:\\windows\\Temp\\setup.xml')
        expect(chef_run).to_not create_template('c:\\windows\\Temp\\not_setup.xml')
      end
      it 'installs appd .net agent windows_package' do
        expect(chef_run).to install_windows_package('AppD .NET Agent')
        expect(chef_run).to_not install_windows_package('NOT AppD .NET Agent')
      end
    end
  end
end
