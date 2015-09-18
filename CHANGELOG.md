appdynamics CHANGELOG
========================

This file is used to list changes made in each version of the appdynamics cookbook.

0.2.0
-----
- [akemner] - jave_agent changes - changed from unzip to use ark cookbook. ark to put all files from zip into opt/appdynamics/javaagent directory. updated install_dir to point to opt/appdynamics. add spec, and integration testing for java. includes two fixture cookbooks, appdynamics-test and test-helper. test-helper allows for dynamic attribute testing with serverspec. locked rubocop to 0.33.0. this required a new gemsfile.lock

0.1.3
-----
- [akemner] - add maintainer_email and fix spec failures

0.1.2
-----
- [dkoepke] - Add support for packages.appdynamics.com, remove "latest" version concept.

0.1.1
-----
- [akemner] - dotnet_agent - add standalone/windows service instrumentation support, includes chefspec and serverspec test for the changes. 

0.1.0
-----
- [akemner] - bump metadata version, add changelog.md, resolve FoodCritic/Rubocop failures for all files, add unit(chefspec) & integration(serverspec) testing for dotnet_agent.rb. remove checksum, notify to template resource so AppDynamics Agent Coordinator restart if template gets changed, subscribe IIS Restart script to AppDynamics Agent Coordinator. 
