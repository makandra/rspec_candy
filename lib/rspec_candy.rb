require 'rspec_candy/version'
require 'rspec_candy/switcher'
require 'rspec_candy/helpers/create_without_callbacks'
require 'rspec_candy/helpers/disposable_copy'
require 'rspec_candy/helpers/new_with_stubs'
require 'rspec_candy/helpers/should_receive_and_execute'
require 'rspec_candy/helpers/should_receive_and_return'
require 'rspec_candy/helpers/should_receive_chain'
require 'rspec_candy/helpers/stub_any_instance'
require 'rspec_candy/helpers/stub_existing'

if RSpecCandy::Switcher.rails_loaded?
  require 'rspec_candy/helpers/rails/prevent_storage'
end
