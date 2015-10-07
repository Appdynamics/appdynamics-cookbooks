Provides usable node information as a tmp json file.

##Configuration example

Include in `.kitchen.yml`:
```
---
driver:
  name: vagrant

provisioner:
  name: chef_zero

platforms:
  - name: centos-6.6

suites:
  - name: default
    run_list:
      - recipe[test-helper]
      - recipe[<<<<>>>>>]
```
##Usage with Server Spec
Update / Configure `spec_helper.rb` to contain:
```
require 'serverspec'
require 'pathname'
require 'json'

if ENV['OS'] == 'Windows_NT'
  set :backend, :cmd
  # On Windows, set the target host's OS explicitely
  set :os, :family => 'windows'
  $node = ::JSON.parse(File.read('c:\windows\temp\serverspec\node.json'))
else
  set :backend, :exec
  $node = ::JSON.parse(File.read('/tmp/serverspec/node.json'))
end

set :path, '/sbin:/usr/local/sbin:$PATH' unless os[:family] == 'windows'
```
#####Usage in tests:
```
describe file("#{$node['appdynamics']['java_agent']['install_dir']}/javaagent/conf") do
  it 'is a directory' do
    expect(subject).to be_directory
  end
  it { should be_owned_by "#{$node['appdynamics']['java_agent']['owner']}" }
end
```
