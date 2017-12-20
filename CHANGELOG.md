appdynamics CHANGELOG
========================

This file is used to list changes made in each version of the appdynamics cookbook.

0.4.1
-----
- [dkoepke] - Switch from deprecated `python` cookbook to `poise-python`
- [dkoepke] - Bump versions, require at least Chef 12.5

0.4.0
-----
- [spuder] - Loosen windows cookbook version pin

0.3.3
-----
- [jcejohnson] - Fix init script for Machine Agent

0.3.2
-----
- [spuder] - Fix file URL schemas for Windows

0.3.1
-----
- [Meldryn] - Pin apt version to be more specific

0.3.0
-----
- [spuder] - Pin dependency versions

0.2.4
-----
- [nmcginnis] - Removed erroneous characters in dotnet template which causes issues with auto instrumentation.

0.2.3
-----
- [akemner] - dynamic integration testing for windows with fixture cookbook test-helper

0.2.2
-----
- [dkoepke] - use windows_package instead of package--we were seeing `package` fail in certain invocations of chef-client due the `source` attribute magically growing a drive letter; update Travis to use rake test

0.2.1
-----
- [akemner] - refactor dotnet_agent so the template managed by chef is the running config.xml rather then setup.xml, drop using setup.xml in the install package, update chefspec and integration tests for dotnet_agent. also resolved issue with ubuntu integration testing for nodejs and python by including apt::default in the runlist for those suites

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
