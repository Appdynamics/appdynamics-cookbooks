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
Linux: Update / Configure `spec_helper.rb` to contain:
```
require 'serverspec'
require 'pathname'
require 'json'

set :backend, :exec

set :path, '/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:$PATH'
$node = ::JSON.parse(File.read('/tmp/serverspec/node.json'))
```
Windows: Update / Configure `spec_helper.rb` to contain:
```
require 'serverspec'
require 'pathname'
require 'json'

set :backend, :cmd
set :os, :family => 'windows'

$node = ::JSON.parse(File.read('c:\windows\temp\serverspec\node.json'))
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
