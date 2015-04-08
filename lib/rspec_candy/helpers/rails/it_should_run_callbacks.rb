module RSpecCandy
  module Helpers
    module Rails
      module ItShouldRunCallbacks

        module ExampleGroupMethods
          def self.included(by)
            by.class_eval do

              def it_should_run_callbacks_in_order(*callbacks)
                callbacks.push(:ordered => true)
                it_should_run_callbacks(*callbacks)
              end

              def it_should_run_callbacks(*callbacks)
                options = callbacks.last.is_a?(Hash) ? callbacks.pop : {}
                reason = callbacks.pop if callbacks.last.is_a?(String)
                should = ['should run callbacks', callbacks.inspect, ('in order' if options[:ordered]), reason].compact.join ' '

                prose = case Switcher.rspec_version
                when 1
                  description_parts.last
                else
                  description.split(/(?=#)/).last
                end

                send(:it, should) do
                  extend ExampleMethods
                  callbacks.each do |callback|
                    expectation = subject.should_receive(callback).once
                    expectation.ordered if options[:ordered]
                  end
                  run_all_callbacks(prose)
                end
              end
            end
          end
        end

        module ExampleMethods
          private

          def run_all_callbacks(prose)
            run_active_record_callbacks_from_prose(prose)
          end

          case Switcher.rspec_version
          when 1

            def run_active_record_callbacks_from_prose(prose)
              subject.run_callbacks(prose.sub(/^#/, ''))
            end

          else

            def run_active_record_callbacks_from_prose(prose)
              hook = prose.split.last.sub(/^#/, '')
              if hook.sub!(/_on_(create|update)$/, '')
                condition = "validation_context == :#{$1}"
              else
                condition = nil
              end
              if hook == 'validate'
                kind = 'before'
                action = 'validate'
              else
                hook =~ /^(before|after|around)_(.*)$/
                kind = $1
                action = $2
              end
              # Run all matching callbacks
              subject.send("_#{action}_callbacks").send(kind == 'after' ? :reverse_each : :each) do |callback|
                if callback.kind.to_s == kind && (condition.nil? || callback.options[:if].include?(condition))
                  subject.send(callback.filter.to_s.gsub(/[\(,\)]/, '').to_sym) {}
                end
              end
            end

          end
        end

        case Switcher.rspec_version
        when 1
          Spec::Example::ExampleGroupMethods.send(:include, self::ExampleGroupMethods)
        else
          RSpec::Core::ExampleGroup.singleton_class.send(:include, self::ExampleGroupMethods)
        end

      end
    end
  end
end
