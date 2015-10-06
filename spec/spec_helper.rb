require 'bundler/setup'

Bundler.require :default, :test
spec_root = File.expand_path(File.dirname(__FILE__))


$: << spec_root

require File.join(File.dirname(__FILE__), '..', 'lib','opsource_client')

Dir[File.join(spec_root, "support/*.rb")].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec, :stdlib
end
