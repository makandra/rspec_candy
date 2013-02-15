module RSpecCandy
  module Helpers
    module ShouldReceiveAndExecute

      def should_receive_and_execute(method)

        method = method.to_s
        method_base = method.gsub(/([\?\!\=\[\]]+)$/, '')
        method_suffix = $1

        method_called = "_#{method_base}_called#{method_suffix}"
        method_with_spy = "#{method_base}_with_spy#{method_suffix}"
        method_without_spy = "#{method_base}_without_spy#{method_suffix}"

        method_defined_directly = (private_methods + protected_methods + public_methods).include?(method) # not method_missing

        prototype = respond_to?(:singleton_class) ? singleton_class : metaclass
        prototype.class_eval do

          define_method method_called do |*args|
          end

          if method_defined_directly
            unless method_defined?(method_with_spy)
              define_method method_with_spy do |*args, &block|
                send(method_called, *args)
                send(method_without_spy, *args, &block)
              end
              alias_method_chain method, :spy
            end
          else
            define_method method do |*args, &block|
              send(method_called, *args)
              super
            end
          end

        end

        should_receive(method_called)
      end

      Object.send(:include, self)

    end
  end
end

