require 'spec_helper'

describe RSpecCandy::Helpers::Rails::PreventStorage do

  describe ActiveRecord::Base do

    describe '#prevent_storage' do

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

        it 'should run before_validate callbacks' do
          klass = Model.disposable_copy do
            before_validation :callback_method
          end
          record = klass.new
          record.prevent_storage
          record.should_receive :callback_method
          record.save
        end

        it 'should run after_validate callbacks' do
          klass = Model.disposable_copy do
            after_validation :callback_method
          end
          record = klass.new
          record.prevent_storage
          record.should_receive :callback_method
          record.save
        end

        it 'should prevent the record from being committed to the database' do
          record = Model.new
          record.prevent_storage
          record.save.should == false
          Model.count.should be_zero
        end

        it 'should not run before_save callbacks' do
          klass = Model.disposable_copy do
            before_save :callback_method
          end
          record = klass.new
          record.prevent_storage
          record.should_not_receive :callback_method
          record.save
        end

        it 'should not run after_save callbacks' do
          klass = Model.disposable_copy do
            after_save :callback_method
          end
          record = klass.new
          record.prevent_storage
          record.should_not_receive :callback_method
          record.save
        end

      end

    end

    describe '#keep_invalid!' do

      it 'should print a deprecation warning asking to use #prevent_storage' do
        record = Model.new
        record.should_receive(:warn).with(/Use prevent_storage instead/i)
        record.should_receive(:prevent_storage)
        record.keep_invalid!
      end

    end

  end

end
