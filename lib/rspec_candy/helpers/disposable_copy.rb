module RSpecCandy
  module Helpers
    module DisposableCopy

      def disposable_copy(&body)
        this = self
        copy = Class.new(self, &body)
        copy.singleton_class.send(:define_method, :name) { this.name }
        copy
      end

      Class.send(:include, self)

    end
  end
end
