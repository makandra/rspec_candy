module RSpecCandy
  module Helpers
    module ShouldReceiveChain

      def should_receive_chain(*parts)
        setup_expectation_chain(parts)
      end

      private

      def setup_expectation_chain(parts)
        obj = self
        for part in parts
          if part == parts.last
            obj = add_expectation_chain_link(obj, part)
          else
            next_obj = Spec::Mocks::Mock.new('chain link')
            add_expectation_chain_link(obj, part).at_least(:once).and_return(next_obj)
            obj = next_obj
          end
        end
        obj
      end

      def add_expectation_chain_link(obj, part)
        if part.is_a?(Array)
          obj.should_receive(part.first).with(*part[1..-1])
        else
          obj.should_receive(part)
        end
      end

      Object.send(:include, self)

    end
  end
end

