require 'rspec_candy/base'
require 'rspec_candy/helpers/disposable_copy'
require 'rspec_candy/helpers/it_should_act_like'
require 'rspec_candy/helpers/new_with_stubs'
require 'rspec_candy/helpers/should_receive_and_execute'
require 'rspec_candy/helpers/should_receive_and_return'
require 'rspec_candy/helpers/should_receive_chain'
require 'rspec_candy/helpers/stub_any_instance'
require 'rspec_candy/helpers/stub_existing'

if RSpecCandy::Switcher.active_record_loaded?
  require 'rspec_candy/helpers/rails/store_with_values'
  require 'rspec_candy/helpers/rails/prevent_storage'
end
