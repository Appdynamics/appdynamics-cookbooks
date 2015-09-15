require_relative 'spec_helper'

describe file("#{$node['appdynamics']['java_agent']['install_dir']}/conf") do
  it 'is a directory' do
    expect(subject).to be_directory
  end
  it { should be_owned_by "#{$node['appdynamics']['java_agent']['owner']}" }
end
describe file("#{$node['appdynamics']['java_agent']['install_dir']}") do
  it 'is a directory' do
    expect(subject).to be_directory
  end
  it { should be_owned_by "#{$node['appdynamics']['java_agent']['owner']}" }
end
describe file("#{$node['appdynamics']['java_agent']['install_dir']}/conf/controller-info.xml") do
  it 'is a file' do
    expect(subject).to be_file
  end
  it { should be_owned_by "#{$node['appdynamics']['java_agent']['owner']}" }
  it { should contain "#{$node['appdynamics']['controller']['host']}" }
  it { should contain "#{$node['appdynamics']['controller']['port']}" }
  it { should contain "#{$node['appdynamics']['controller']['ssl']}" }
  it { should contain "#{$node['appdynamics']['controller']['user']}" }
  it { should contain "#{$node['appdynamics']['controller']['accesskey']}" }
  it { should contain "#{$node['appdynamics']['app_name']}" }
  it { should contain "#{$node['appdynamics']['tier_name']}" }
  it { should contain "#{$node['appdynamics']['node_name']}" }
end
describe file("#{$node['appdynamics']['java_agent']['install_dir']}/javaagent/javaagent.jar") do
  it 'is a file' do
    expect(subject).to be_file
  end
  it { should be_owned_by "#{$node['appdynamics']['java_agent']['owner']}" }
end