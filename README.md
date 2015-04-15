# AppDynamics Cookbooks

[![Build Status](https://travis-ci.org/Appdynamics/appdynamics-cookbooks.svg?branch=master)](https://travis-ci.org/Appdynamics/appdynamics-cookbooks)

Cookbooks for installing AppDynamics agents.

**This cookbook is a WIP. It currently only covers the Python and Node.js agents. See the issues for what we're working on.**

Learn more about AppDynamics at:

* http://www.appdynamics.com/ (and check out the handsome devil next to the "Act" bubble in the photo)
* https://docs.appdynamics.com/display/PRO40/Getting+Started
* https://docs.appdynamics.com/display/PRO40/Install+and+Administer+Agents

## Requirements

* Chef >= 0.10.0
* python cookbook
* nodejs cookbook
* Python and Node.JS recipes are tested on Ubuntu and CentOS

## Attributes

For more information about these settings, please refer to the AppDynamics documentation for the relevant agent:

* [Install the Node.js Agent - Advanced Instructions](https://docs.appdynamics.com/display/PRO40/Install+the+Node.js+Agent#InstalltheNode.jsAgent-AdvancedInstructions)
* [Python Agent Settings](https://docs.appdynamics.com/display/PRO40/Python+Agent+Settings+-+Beta)

### Default Attributes

These attributes are used with the `_agent` recipes:

* `node['appdynamics']['app_name']` - The name to register your application under with the AppDynamics controller.
* `node['appdynamics']['tier_name']` - The name to register this tier of your application under with the AppDynamics controller.
* `node['appdynamics']['node_name']` - The name to register this node of your application under with the AppDynamics controller.
* `node['appdynamics']['controller']['host']` - The host your AppDynamics controller is running on (a domain name or IP address). **Required**
* `node['appdynamics']['controller']['port']` - The port your AppDynamics controller is running on.
* `node['appdynamics']['controller']['ssl']` - Flag indicating if SSL should be used to speak to the controller (`true`) or not (`false`). Defaults to `true`. SaaS controllers do not support the value `false` for this flag.
* `node['appdynamics']['controller']['user']` - If you need to authenticate with your controller, the account name.
* `node['appdynamics']['controller']['accesskey']` - If you need to authenticate with your controller, the accesskey for accessing your AppDynamics controller.

### HTTP Proxy Attributes

If your agents must use an HTTP proxy to communicate with the controller, set these attributes:

* `node['appdynamics']['http_proxy']['host']` - The hostname/IP of your HTTP proxy.
* `node['appdynamics']['http_proxy']['port']` - The port of your HTTP proxy.
* `node['appdynamics']['http_proxy']['user']` - If you must authenticate with your HTTP proxy, the user name to authenticate as.
* `node['appdynamics']['http_proxy']['password_file']` - If you must authenticate with your HTTP proxy, the complete path to a file you will create on a machine using an AppDynamics agent that contains the password used for authenticating with your HTTP proxy.

### Python Agent Configuration Attributes

The `python_agent` recipe has some additional attributes you may set:

* `node['appdynamics']['python_agent']['virtualenv']` - The path to the Python virtualenv to install the Python agent into.
* `node['appdynamics']['python_agent']['version']` - The version of the Python agent you wish to use. If not set, `latest`.
* `node['appdynamics']['python_agent']['debug']` - If set to `true`, the Python agent will start in debug mode.
* `node['appdynamics']['python_agent']['dir']` - Set to the path you want the agent to use for storing its runtime data. It defaults to `/tmp/appd`.

## Usage

### Instrumenting a Python WSGI Application

**Step 1.** Set the following node attributes (documented above):

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

**Step 2.** Add `recipe[appdynamics::python_agent]` to your run list.

**Step 3.** Update your recipes that deploy your application to enable the Python agent in your application. See [Instrument Python Applications](https://docs.appdynamics.com/display/PRO40/Instrument+Python+Applications+-+Beta#InstrumentPythonApplications-Beta-InstrumenttheApplication).
