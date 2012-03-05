module RSpecCandy
  module Helpers
    module ShouldReceiveAndReturn

      def should_receive_and_return(methods_and_values)
        methods_and_values.each do |method, value|
          should_receive(method).and_return(value)
        end
        self
      end

      Object.send(:include, self)

    end
  end
end

