chef_gem 'activesupport'

require 'pathname'
require 'active_support/core_ext/hash/deep_merge'

case node['platform_family']
when 'debian', 'rhel', 'fedora'
  temp_path = '/tmp/serverspec/'
  directory temp_path do
    recursive true
  end

  file "#{temp_path}node.json" do
    owner 'root'
    mode '0400'
  end
when 'windows'
  temp_path = 'c:\\windows\\temp\\serverspec\\'
  directory temp_path do
    recursive true
  end

  file "#{temp_path}node.json" do
  end
end

log "Dumping attributes to 'node.json'"

ruby_block 'dump_node_attributes' do
  block do
    require 'json'

    attrs = {}

    attrs = attrs.deep_merge(node.automatic_attrs) unless node.automatic_attrs.empty?
    attrs = attrs.deep_merge(node.default_attrs) unless node.default_attrs.empty?
    attrs = attrs.deep_merge(node.normal_attrs) unless node.normal_attrs.empty?
    attrs = attrs.deep_merge(node.override_attrs) unless node.override_attrs.empty?

    recipe_json = "{ \"run_list\": \[ "
    recipe_json << node.run_list.expand(node.chef_environment).recipes.map! { |k| "\"#{k}\"" }.join(',')
    recipe_json << " \] }"
    attrs = attrs.deep_merge(JSON.parse(recipe_json))

    File.open("#{temp_path}node.json", 'w') { |file| file.write(JSON.pretty_generate(attrs)) }
  end
end
