require_relative 'spec_helper'

describe file('c:\\windows\\Temp') do
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
describe file('c:\\windows\\Temp\\setup.xml') do
  it 'is a file' do
    expect(subject).to be_file
  end
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
