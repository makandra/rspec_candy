require 'spec_helper'

describe RSpecCandy::Helpers::Rails::PreventStorage do

  describe ActiveRecord::Base do

    describe '#prevent_callbacks' do

      context 'when attempting to save the record afterwards' do

        it 'should run validations' do
          klass = Model.disposable_copy do
            validate :validation_method
          end
          record = klass.new
          record.prevent_storage
          record.should_receive :validation_method
          record.save
        end

        it 'should run before_validate callbacks'

        it 'should run after_validate callbacks'

        it 'should run before_save callbacks'

        it 'should prevent the record from being committed to the database'

        it 'should not run after_save callbacks'

      end

    end

    describe '#keep_invalid!' do

      it 'should print a deprecation warning asking to use #prevent_callbacks'

    end

  end

end
