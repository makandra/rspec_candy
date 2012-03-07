module RSpecCandy
  module Helpers
    module CreateWithoutCallbacks

      def create_without_callbacks(*args)
        table_name = self.table_name
        plain_model = Class.new(ActiveRecord::Base) do
          self.table_name = table_name
        end
        plain_record = plain_model.create!(*args)
        find plain_record.id
      end

      def new_and_store(*args)
        warn 'new_and_store is deprecated. Use create_without_callbacks instead.'
      end

      ActiveRecord::Base.send(:extend, self)

    end
  end
end