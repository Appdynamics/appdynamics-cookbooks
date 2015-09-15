require 'serverspec'
require 'pathname'
require 'json'

set :backend, :exec

set :path, '/sbin:/usr/local/sbin:/usr/local/bin:/usr/sbin:$PATH'
$node = ::JSON.parse(File.read('/tmp/serverspec/node.json'))
