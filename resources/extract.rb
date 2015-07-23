#
# Author:: Dan Koepke <dan.koepke@appdynamics.com>
# Cookbook Name:: appdynamics
# Resource:: extract
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

actions :run
default_action :run

attribute :basename, kind_of: String, name_attribute: true, required: true
attribute :source, kind_of: String, required: true
attribute :dest, kind_of: String, required: true

attribute :type, kind_of: [Symbol, NilClass]
attribute :owner, kind_of: [String, Integer, NilClass]
attribute :group, kind_of: [String, Integer, NilClass]
attribute :checksum, kind_of: [String, NilClass]
