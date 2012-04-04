module RSpecCandy
  module Helpers
    module StubAnyInstance

      def stub_any_instance(stubs)
        case Switcher.rspec_version
        when :rspec1
          unstubbed_new = method(:new)
          stub(:new).and_return do |*args|
            unstubbed_new.call(*args).tap do |obj|
              obj.stub stubs
            end
          end
          stubs
        when :rspec2
          any_instance.stub(stubs)
        end
      end

      Class.send(:include, self)

    end
  end
end

