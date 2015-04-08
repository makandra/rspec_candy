module RSpecCandy
  module Helpers
    module Rails
      module StoreWithValues

        def store_with_values(values = {})
          record = new
          case Switcher.active_record_version
          when 2
            record.send(:attributes=, values, false)
            record.send(:create_without_callbacks)
          when 3
            require 'sneaky-save'
            record.assign_attributes(values, :without_protection => true)
            record.sneaky_save
          else
            require 'sneaky-save'
            record.assign_attributes(values)
            record.sneaky_save
          end
          record
        end

        def new_and_store(*args)
          warn 'new_and_store is deprecated. Use store_with_values instead.'
          store_with_values(*args)
        end

        def create_without_callbacks(*args)
          warn 'create_without_callbacks is deprecated because the name suggested that it honors mass-assignment protection. Use store_with_values instead.'
          store_with_values(*args)
        end

        ActiveRecord::Base.send(:extend, self)

      end
    end
  end
end
