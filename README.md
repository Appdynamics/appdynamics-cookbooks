# AppDynamics Cookbooks

[![Build Status](https://travis-ci.org/Appdynamics/appdynamics-cookbooks.svg?branch=master)](https://travis-ci.org/Appdynamics/appdynamics-cookbooks)

Cookbooks for installing AppDynamics agents.

**This cookbook is a WIP. See the issues for what we're working on.**

Learn more about AppDynamics at:

* http://www.appdynamics.com/ (and check out the handsome devil next to the "Act" bubble in the photo)
* https://docs.appdynamics.com/display/PRO41/Getting+Started
* https://docs.appdynamics.com/display/PRO41/Install+and+Administer+Agents

## Requirements

* Chef >= 0.10.0
* python cookbook
* nodejs cookbook
* windows cookbook
* java cookbook
* apt cookbook
* Python and Node.JS recipes are tested on Ubuntu and CentOS
* .Net recipes are tested on Windows2012r2 and Windows2008r2

## Attributes

For more information about these settings, please refer to the AppDynamics documentation for the relevant agent:

* [Install the Node.js Agent - Advanced Instructions](https://docs.appdynamics.com/display/PRO41/Install+the+Node.js+Agent#InstalltheNode.jsAgent-AdvancedInstructions)
* [Python Agent Settings](https://docs.appdynamics.com/display/PRO41/Python+Agent+Setting)
* [Java Agent Settings](https://docs.appdynamics.com/display/PRO41/Install+the+Java+Agent)
* [.NET Agent Settings](https://docs.appdynamics.com/display/PRO41/Install+the+.NET+Agent)

### Default Attributes

These node attributes must be set to use the `_agent` recipes:

* `node['appdynamics']['app_name']` - The name to register your application under with the AppDynamics controller.
* `node['appdynamics']['tier_name']` - The name to register this tier of your application under with the AppDynamics controller.
* `node['appdynamics']['node_name']` - The name to register this node of your application under with the AppDynamics controller.
* `node['appdynamics']['version']` - The version of AppDynamics to use.
* `node['appdynamics']['controller']['host']` - The host your AppDynamics controller is running on (a domain name or IP address). **Required**
* `node['appdynamics']['controller']['port']` - The port your AppDynamics controller is running on.
* `node['appdynamics']['controller']['user']` - The account name to use with your AppDynamics controller.
* `node['appdynamics']['controller']['accesskey']` - The access key for your account for accessing your AppDynamics controller.

Optional attributes:

* `node['appdynamics']['packages_site']` - The base URL of the AppDynamics packages site (defaults to `https://packages.appdynamics.com`).
* `node['appdynamics']['controller']['ssl']` - Flag indicating if SSL should be used to speak to the controller (`true`) or not (`false`). Defaults to `true`. SaaS controllers do not support the value `false` for this flag.

### HTTP Proxy Attributes

If your agents must use an HTTP proxy to communicate with the controller, set these attributes:

* `node['appdynamics']['http_proxy']['host']` - The hostname/IP of your HTTP proxy.
* `node['appdynamics']['http_proxy']['port']` - The port of your HTTP proxy.
* `node['appdynamics']['http_proxy']['user']` - If you must authenticate with your HTTP proxy, the user name to authenticate as.
* `node['appdynamics']['http_proxy']['password_file']` - If you must authenticate with your HTTP proxy, the complete path to a file you will create on a machine using an AppDynamics agent that contains the password used for authenticating with your HTTP proxy.

### Python Agent Configuration Attributes

The `python_agent` recipe has some additional attributes you may set:

* `node['appdynamics']['python_agent']['virtualenv']` - The path to the Python virtualenv to install the Python agent into.
* `node['appdynamics']['python_agent']['version']` - The version of the Python agent you wish to use. If set, overrides the version set in `node['appdynamics']['version']`.
* `node['appdynamics']['python_agent']['debug']` - If set to `true`, the Python agent will start in debug mode.
* `node['appdynamics']['python_agent']['dir']` - Set to the path you want the agent to use for storing its runtime data. It defaults to `/tmp/appd`.
* `node['appdynamics']['python_agent']['source']` - Specify a full URL here if you wish to download the Python agent from another location than the default packages site.


#### Java Agent Configuration Attributes

The `java_agent` recipe has some additional attributes you may set:

* `node['appdynamics']['java_agent']['source']`
* `node['appdynamics']['java_agent']['version']`
* `node['appdynamics']['java_agent']['checksum']` - The sha256 checksum of the installer. Required to prevent cookbook from redownloading agent installer every chef run. 
* `node['appdynamics']['java_agent']['zip']`
* `node['appdynamics']['java_agent']['install_dir']`
* `node['appdynamics']['java_agent']['owner']`
* `node['appdynamics']['java_agent']['group']`

## Usage

### Instrumenting a Python WSGI Application

**Step 1.** Set the following node attributes (documented above):

* `node['appdynamics']['version']` *OR* `node['appdynamics']['python_agent']['version']`
* `node['appdynamics']['app_name']`
* `node['appdynamics']['tier_name']`
* `node['appdynamics']['node_name']`
* `node['appdynamics']['controller']['host']`
* `node['appdynamics']['controller']['port']`
* `node['appdynamics']['controller']['user']`
* `node['appdynamics']['controller']['accesskey']`
* `node['appdynamics']['python_agent']['virtualenv']`

For example, you might set these in a Chef role file:

```ruby
default_attributes (
  'appdynamics' => {
    'app_name' => 'my app',
    'tier_name' => 'frontend',
    'node_name' => node.name,
    'version' => '4.1.2.0',
    'controller' => {
      'host' => 'my-controller',
      'port' => '8181',
      'ssl' => true,
      'user' => 'someuser',
      'accesskey' => 'supersecret',
    },
    'python_agent' => {
      'virtualenv' => '/path/to/my/virtualenv'
    }
  }
)
```

**Step 2.** Add `recipe[appdynamics::python_agent]` to your run list.

**Step 3.** Update your recipes that deploy your application to enable the Python agent in your application. See [Instrument Python Applications](https://docs.appdynamics.com/display/PRO40/Instrument+Python+Applications+-+Beta#InstrumentPythonApplications-Beta-InstrumenttheApplication).

### .Net Agent Configuration Attributes

The `dotnet_agent` recipe has some additional attributes you may set:

* `node['appdynamics']['dotnet_agent']['version']` - The version of the .net agent you wish to use. If not set, `node['appdynamics']['version']` is used.
* `node['appdynamics']['dotnet_agent']['install_dir']` - Set to the path you want the agent to be installed at, it defaults to `C:\Program Files\Appdynamics`.
* `node['appdynamics']['dotnet_agent']['source']` - base url for downloading the agent from.
* `node['appdynamics']['dotnet_agent']['logfiles_dir']` - Set the logfile directory. defaults to `C:\DotNetAgent\Logs`.
* `node['appdynamics']['dotnet_agent']['instrument_iis']` - defaults to false. override to `true` if iis instrumentation is needed.
* `node['appdynamics']['dotnet_agent']['standalone_apps']` - defaults to nil. use this to instrument windows services and/or standalone apps. make sure restart = false for apps that are not windows services, because the service resource will fail trying to restart a non-windows service.

## Usage

### Instrumenting a .Net IIS Application

**Step 1.** Set the following node attributes (documented above):

* `node['appdynamics']['version']`
* `node['appdynamics']['app_name']`
* `node['appdynamics']['controller']['host']`
* `node['appdynamics']['controller']['port']`
* `node['appdynamics']['controller']['user']`
* `node['appdynamics']['controller']['accesskey']`
* `node['appdynamics']['dotnet_agent']['instrument_iis']`
* `node['appdynamics']['dotnet_agent']['standalone_apps']`

For example, you might set these in a Chef role file:

```ruby
default_attributes (
  'appdynamics' => {
    'app_name' => 'my app',
    'controller' => {
      'host' => 'my-controller',
      'port' => '8181',
      'ssl' => true,
      'user' => 'someuser',
      'accesskey' => 'supersecret'
    }
    'dotnet_agent' => {
      'instrument_iis' => true,
      'standalone_apps' => [
        {
          'name' => 'WindowsServiceNameA', 'executable' => 'a.exe', 'tier' => 'TierA', 'commandline' => 'nil', 'restart' => true
        },
        {
          'name' => 'ExecutableNameB', 'executable' => 'b.exe', 'tier' => 'TierB', 'commandline' => '-a -b', 'restart' => false
        }
      ]
    }
  }
)
```

**Step 2.** Add `recipe[appdynamics::dotnet_agent]` to your run list.
