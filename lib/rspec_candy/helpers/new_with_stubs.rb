module RSpecCandy
  module Helpers
    module NewWithStubs

      def new_with_stubs(stubs)
        obj = new
        obj.stub_existing stubs
        obj
      end

      Class.send(:include, self)

    end
  end
end

