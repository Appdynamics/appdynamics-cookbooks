require 'spec_helper'

describe 'appdynamics::java_agent' do
  context 'ubuntu' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.set['appdynamics']['java_agent']['version'] = '4.1.3.0'
        node.set['appdynamics']['java_agent']['owner'] = 'someuser'
        node.set['appdynamics']['app_name'] = 'myapp'
        node.set['appdynamics']['controller']['host'] = 'appdynamics-controller.domain.com'
        node.set['appdynamics']['controller']['port'] = '443'
        node.set['appdynamics']['controller']['user'] = 'someuser'
        node.set['appdynamics']['controller']['accesskey'] = 'supersecret'
      end.converge(described_recipe)
    end
    it 'installs a package unzip' do
      expect(chef_run).to install_package('unzip')
    end
    it 'creates a directory /opt/appdynamics/javaagent/conf with someuser' do
      expect(chef_run).to create_directory('/opt/appdynamics/javaagent/conf').with(
      user:   'someuser'
    )
    end
    it 'runs ark to unzip-appdynamics-java-agent' do
      expect(chef_run).to dump_ark('unzip-appdynamics-java-agent')
    end
    it 'creates controller-info.xml from template' do
      expect(chef_run).to create_template('/opt/appdynamics/javaagent/conf/controller-info.xml')
    end
  end
  context 'centos' do
    let(:chef_run) do
      ChefSpec::SoloRunner.new(platform: 'centos', version: '6.4') do |node|
        node.set['appdynamics']['java_agent']['version'] = '4.1.3.0'
        node.set['appdynamics']['java_agent']['owner'] = 'someuser'
        node.set['appdynamics']['app_name'] = 'myapp'
        node.set['appdynamics']['controller']['host'] = 'appdynamics-controller.domain.com'
        node.set['appdynamics']['controller']['port'] = '443'
        node.set['appdynamics']['controller']['user'] = 'someuser'
        node.set['appdynamics']['controller']['accesskey'] = 'supersecret'
      end.converge(described_recipe)
    end
    it 'installs a package unzip' do
      expect(chef_run).to_not install_package('unzip')
    end
    it 'creates a directory /opt/appdynamics/javaagent/conf with someuser' do
      expect(chef_run).to create_directory('/opt/appdynamics/javaagent/conf').with(
      user:   'someuser'
    )
    end
    it 'runs ark to unzip-appdynamics-java-agent' do
      expect(chef_run).to dump_ark('unzip-appdynamics-java-agent')
    end
    it 'creates controller-info.xml from template' do
      expect(chef_run).to create_template('/opt/appdynamics/javaagent/conf/controller-info.xml')
    end
  end
end
