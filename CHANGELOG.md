appdynamics CHANGELOG
========================

This file is used to list changes made in each version of the appdynamics cookbook.

0.1.6
-----
- [amacaraeg] - changing unzip option to ark resource so it includes permissions override.  removing directory resource located below it as it is not needed

0.1.5
-----
- [amacaraeg] - including an option to change permissions to something else after files are unzipped

0.1.4
-----
- [akemner] - add directory resource for java install_dir, add spec, and integration testing for java

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
