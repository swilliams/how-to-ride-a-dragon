require 'test/unit'

require_relative '../lib/harness.rb'
Dir['./test/dummy/app/models/**/*.rb'].each { |f| require f }
