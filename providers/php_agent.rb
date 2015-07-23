#
# Author:: Dan Koepke <dan.koepke@appdynamics.com>
# Cookbook Name:: appdynamics
# Provider:: php_agent
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

require_relative '../libraries/helpers'
include AppDynamicsCookbook::Helpers

def whyrun_supported?
  true
end

use_inline_resources

action :install do
  version = new_resource.version
  tarball_source = new_resource.source || default_source(version)

  appdynamics_extract "#{new_resource.name} :run extract" do
    basename "appdynamics-php-agent-#{version}.tar.bz2"
    type :tar_bz2
    source tarball_source
    dest new_resource.dest
    owner new_resource.owner unless new_resource.owner.nil?
    group new_resource.group unless new_resource.group.nil?
    notifies :run, "execute[#{new_resource.name} :run install.sh]", :immediately
  end

  new_resource.updated_by_last_action(true)

  install_command = ["./install.sh"]
  install_command << '-s' if new_resource.controller_ssl
  install_command << "-a=#{new_resource.account}@#{new_resource.accesskey}"
  install_command << "--http-proxy-host=#{new_resoure.http_proxy_host}" if new_resource.http_proxy_host
  install_command << "--http-proxy-port=#{new_resoure.http_proxy_port}" if new_resource.http_proxy_port
  install_command << "--http-proxy-user=#{new_resoure.http_proxy_user}" if new_resource.http_proxy_user
  install_command << "--http-proxy-password-file=#{new_resoure.http_proxy_password_file}" if new_resource.http_proxy_password_file
  install_command << "#{new_resource.controller_host} #{new_resource.controller_port}"
  install_command << "#{new_resource.app_name} #{new_resource.tier_name} #{new_resource.node_name}"

  execute "#{new_resource.name} :run install.sh" do
    action :nothing
    command install_command
    cwd "#{new_resource.dest}/appdynamics-php-agent"
    user new_resource.owner unless new_resource.owner.nil?
    group new_resource.group unless new_resource.group.nil?
  end

  new_resource.updated_by_last_action(true)
end

def default_source(version)
  plat = platform(node['kernel']['os'], %w(linux osx))
  arch = architecture(node['kernel']['machine'], %w(x86 x64))
  "https://packages.appdynamics.com/#{version}/php/appdynamics-php-agent-#{plat}-#{arch}-#{version}.tar.bz2"
end
