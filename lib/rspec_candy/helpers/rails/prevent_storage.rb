module RSpecCandy
  module Helpers
    module Rails
      module PreventStorage

        def prevent_storage
          errors.stub :empty? => false
        end

        def keep_invalid!
          warn 'keep_invalid! is deprecated. Use prevent_storage instead.'
          prevent_storage
        end

        ActiveRecord::Base.send(:include, self)

      end
    end
  end
end
