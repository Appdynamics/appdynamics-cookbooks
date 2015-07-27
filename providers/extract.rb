#
# Author:: Dan Koepke <dan.koepke@appdynamics.com>
# Cookbook Name:: appdynamics
# Provider:: extract
#
# Copyright:: 2015, AppDynamics, Inc and its affiliates
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

commands = { :zip => ['unzip', '-qq'], :tar_bz2 => ['tar', 'xjf'], :tar_gz => ['tar', 'xzf'] }

def whyrun_supported?
  true
end

use_inline_resources

action :run do
  tmp_dest = "#{Chef::Config[:file_cache_path]}/#{new_resource.name}"

  install_type = new_resource.type || guess_type(new_resource.basename)
  package 'unzip' if install_type == :zip

  raise "Unsupported type #{install_type}" if commands[install_type].nil?
  install_command = commands[install_type] + [tmp_dest]

  directory "#{new_resource.name} :create #{new_resource.dest}" do
    recursive true
    path new_resource.dest
    owner new_resource.owner unless new_resource.owner.nil?
    group new_resource.group unless new_resource.group.nil?
    mode '0644'
  end

  remote_file "#{new_resource.name} :create #{tmp_dest}" do
    source new_resource.source
    path tmp_dest
    owner new_resource.owner unless new_resource.owner.nil?
    group new_resource.group unless new_resource.group.nil?
    checksum new_resource.checksum unless new_resource.checksum.nil?
    notifies :run, "execute[#{new_resource.name} :run extract]", :immediately
  end

  new_resource.updated_by_last_action(true)

  execute "#{new_resource.name} :run extract" do
    action :nothing

    command install_command
    cwd new_resource.dest
    user new_resource.owner unless new_resource.owner.nil?
    group new_resource.group unless new_resource.group.nil?
  end

  new_resource.updated_by_last_action(true)
end

def guess_type(name)
  if name.end_with? '.zip'
    return :zip
  elsif name.end_with? '.tar.bz2'
    return :tar_bz2
  elsif name.end_with? '.tar.gz'
    return :tar_gz
  end
  raise "Cannot guess archive type, please specify 'type' attribute"
end
