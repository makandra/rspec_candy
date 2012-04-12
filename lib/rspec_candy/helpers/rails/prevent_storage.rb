module RSpecCandy
  module Helpers
    module Rails
      module PreventStorage

        def prevent_storage
          errors.stub :empty? => false
        end

        ActiveRecord::Base.send(:include, self)

      end
    end
  end
end
