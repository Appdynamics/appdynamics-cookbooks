appdynamics CHANGELOG
========================

This file is used to list changes made in each version of the appdynamics cookbook.

0.0.1
-----
- [Al Kemner] - bump metadata version, add changelog.md, resolve FoodCritic/Rubocop failures for all files, add unit(chefspec) & integration(serverspec) testing for dotnet_agent.rb. remove checksum, subscripe AppDynamics Agent Coordinator to config template so appd service will restart automaticly if template properties get changed, subscribe IIS Restart to AppDynamics Agent Coordinator only if iis is instrumented == true. 
