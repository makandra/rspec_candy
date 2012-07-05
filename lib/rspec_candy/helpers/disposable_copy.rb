module RSpecCandy
  module Helpers
    module DisposableCopy

      def disposable_copy(&body)
        this = self
        copy = Class.new(self)
        copy.singleton_class.send(:define_method, :name) { this.name }
        copy.class_eval(&body) if body
        copy
      end

      Class.send(:include, self)

    end
  end
end
