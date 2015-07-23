actions :install
default_action :install

attribute :dest, kind_of: String, required: true
attribute :version, kind_of: String, regex: /^\d+\.\d+.\d+.\d+/, required: true
attribute :source, kind_of: [String, NilClass], default: nil
attribute :checksum, kind_of: [String, NilClass], default: nil

attribute :app_name, kind_of: String, required: true
attribute :tier_name, kind_of: String, required: true
attribute :node_name, kind_of: String, name_attribute: true

attribute :controller_host, kind_of: String, required: true
attribute :controller_port, kind_of: [String, Integer], default: 443
attribute :controller_ssl, kind_of: [TrueClass, FalseClass], default: true
attribute :account, kind_of: String, default: 'customer1'
attribute :accesskey, kind_of: String, required: true

attribute :http_proxy_host, kind_of: [String, NilClass], default: nil
attribute :http_proxy_port, kind_of: [String, Integer, NilClass], default: nil
attribute :http_proxy_user, kind_of: [String, NilClass], default: nil
attribute :http_proxy_password_file, kind_of: [String, NilClass], default: nil

attribute :owner, kind_of: [String, Integer, NilClass], default: nil
attribute :group, kind_of: [String, Integer, NilClass], default: nil
