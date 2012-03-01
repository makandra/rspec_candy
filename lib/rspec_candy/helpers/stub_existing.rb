module RSpecCandy
  module Helpers
    module StubExisting

      def stub_existing(attrs)
        attrs.each do |method, value|
          if respond_to?(method, true)
            stub(method => value)
          else
            raise "Attempted to stub non-existing method ##{method} on #{inspect}"
          end
        end
      end

      Object.send(:include, self)
      
    end
  end
end

