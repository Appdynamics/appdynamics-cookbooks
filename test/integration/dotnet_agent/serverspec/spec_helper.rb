require 'serverspec'
require 'pathname'
require 'json'

set :backend, :cmd
set :os, :family => 'windows'

$node = ::JSON.parse(File.read('c:\windows\temp\serverspec\node.json'))
