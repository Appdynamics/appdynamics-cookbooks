require_relative 'spec_helper'

describe file("#{$node['kernel']['os_info']['windows_directory']}\\Temp") do
  it 'is a directory' do
    expect(subject).to be_directory
  end
end
describe service('MSDTC') do
  it 'enabled' do
    expect(subject).to be_enabled
  end
  it 'is running' do
    expect(subject).to be_running
  end
end
describe service('Winmgmt') do
  it 'enabled' do
    expect(subject).to be_enabled
  end
  it 'is running' do
    expect(subject).to be_running
  end
end
describe windows_feature('IIS-RequestMonitor') do
  it 'installed' do
    expect(subject).to be_installed
  end
end
describe file("#{$node['kernel']['os_info']['system_drive']}\\ProgramData\\AppDynamics\\DotNetAgent\\Config\\config.xml") do
  it 'is a file' do
    expect(subject).to be_file
  end
  it { should contain 'test-app' }
  it { should contain 'controller-host' }
  it { should contain 'controller-accesskey' }
  it { should contain 'automatic' }
  it { should contain 'svchost.exe' }
  it { should contain 'msdtc.exe' }
  it { should contain 'command-line="-k iissvcs"' }
  it { should contain 'name="msdtc"' }
  it { should contain 'name="w3svc"' }
end
describe package('AppDynamics .NET Agent') do
  it 'is installed' do
    expect(subject).to be_installed
  end
end
describe service('AppDynamics.Agent.Coordinator_service') do
  it 'enabled' do
    expect(subject).to be_enabled
  end
  it 'is running' do
    expect(subject).to be_running
  end
end
