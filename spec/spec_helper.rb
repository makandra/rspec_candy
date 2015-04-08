# encoding: utf-8

$: << File.join(File.dirname(__FILE__), "/../../lib" )

require 'rspec_candy/all'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}
Dir["#{File.dirname(__FILE__)}/shared_examples/**/*.rb"].each {|f| require f}

