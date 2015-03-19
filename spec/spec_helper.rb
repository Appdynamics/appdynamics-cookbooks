require 'chefspec'
require 'chefspec/berkshelf'
require 'pathname'

RSpec.configure do |config|
  config.log_level = :error
end

def fixture_file(*args)
  Pathname(__FILE__).parent.join('fixtures', *args)
end
