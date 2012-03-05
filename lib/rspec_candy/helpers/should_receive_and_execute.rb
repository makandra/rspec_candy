module RSpecCandy
  module Helpers
    module ShouldReceiveAndExecute

      def should_receive_and_execute(method)
        method_base = method.to_s.gsub(/([\?\!\=\[\]]+)$/, '')
        method_suffix = $1

        method_called = "_#{method_base}_called#{method_suffix}"
        method_with_spy = "#{method_base}_with_spy#{method_suffix}"
        method_without_spy = "#{method_base}_without_spy#{method_suffix}"

        prototype = respond_to?(:singleton_class) ? singleton_class : metaclass
        prototype.class_eval do

          unless method_defined?(method_with_spy)

            define_method method_called do
            end

            define_method method_with_spy do |*args, &block|
              send(method_called, *args)
              send(method_without_spy, *args, &block)
            end
            alias_method_chain method, :spy
          end

        end

        should_receive(method_called)
      end

      Object.send(:include, self)

    end
  end
end

