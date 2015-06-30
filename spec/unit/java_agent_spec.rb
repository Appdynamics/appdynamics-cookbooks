require 'spec_helper'

describe 'appdynamics::java_agent' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['appdynamics']['app_name'] = 'app-name'
      node.set['appdynamics']['tier_name'] = 'tier-name'
      node.set['appdynamics']['node_name'] = 'node-name'
    end.converge(described_recipe)
  end
end
