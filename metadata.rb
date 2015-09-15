name              'appdynamics'
version           '0.1.7'

maintainer        'AppDynamics'
maintainer_email  'help@appdynamics.com'
description       'Installs and configures AppDynamics agents'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
source_url        'https://github.com/appdynamics/appdynamics-cookbooks'        if respond_to?(:source_url)
issues_url        'https://github.com/appdynamics/appdynamics-cookbooks/issues' if respond_to?(:issues_url)

depends 'windows'
depends 'python'
depends 'nodejs'
depends 'java'
depends 'apt'
depends 'powershell'
depends 'ark'

# Red Hat
supports 'amazon'
supports 'centos'
supports 'fedora'
supports 'oracle'
supports 'redhat'
supports 'scientific'

# Debian
supports 'debian'
supports 'linuxmint'
supports 'ubuntu'

# Mac
supports 'mac_os_x'
supports 'mac_os_x_server'

# Windows
supports 'mswin'
supports 'windows'
