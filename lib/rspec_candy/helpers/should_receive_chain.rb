module RSpecCandy
  module Helpers
    module ShouldReceiveChain

      def should_receive_chain(*parts)
        setup_expectation_chain(parts)
      end

      def should_not_receive_chain(*parts)
        setup_expectation_chain(parts, :negate => true)
      end

      private

      def setup_expectation_chain(parts, options = {})
        obj = self
        for part in parts
          if part == parts.last
            expectation = options[:negate] ? :should_not_receive : :should_receive
            obj = add_expectation_chain_link(obj, expectation, part)
          else
            next_obj = double('chain link')
            add_expectation_chain_link(obj, :stub, part).and_return(next_obj)
            obj = next_obj
          end
        end
        obj
      end

      def add_expectation_chain_link(obj, expectation, part)
        if part.is_a?(Array)
          obj.send(expectation, part.first).with(*part[1..-1])
        else
          obj.send(expectation, part)
        end
      end

      Object.send(:include, self)

    end
  end
end

