# encoding: utf-8

$: << File.join(File.dirname(__FILE__), "/../../lib" )

require 'rspec_candy/all'
if ENV['REQUIRE_STATE_MACHINE'] == 'true' # megahax
  require 'state_machine' # optional dependency
end

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/shared_examples/**/*.rb"].each {|f| require f}

