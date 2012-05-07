module RSpecCandy
  module Helpers
    module ItShouldActLike

      def self.included(by)
        by.class_eval do

          # Improves it_should_behave_like in some ways:
          # - It scopes the reused examples so #let und #subject does not bleed into the reusing example groups
          # - It allows to parametrize the reused example group by appending a hash argument.
          #   Every key/value pair in the hash will become a #let variable for the reused example group
          # - You can call it with a block. It will be available to the reused example group as let(:block)
          def it_should_act_like(shared_example_group, environment = {}, &block)
            if Switcher.rspec_version == :rspec2
              warn('"it_should_act_like" is deprecated. Consider using "it_should_behave_like".')
            end

            description = "as #{shared_example_group}"
            description << " (#{environment.inspect})" if environment.present?
            describe description do
              environment.each do |name, value|
                let(name) { value }
              end
              let(:block) { block } if block
              it_should_behave_like(shared_example_group)
            end
          end
        end
      end

      case Switcher.rspec_version
      when :rspec1
        Spec::Example::ExampleGroupMethods.send(:include, self)
      when :rspec2
        RSpec::Core::ExampleGroup.singleton_class.send(:include, self)
      end
    end
  end
end
