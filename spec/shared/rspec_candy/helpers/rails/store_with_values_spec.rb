require 'spec_helper'
require 'has_defaults'

describe RSpecCandy::Helpers::Rails::StoreWithValues do

  describe ActiveRecord::Base do

    describe '.store_with_values' do

      it 'should run after_initialize callbacks' do
        model = Model.disposable_copy do
          has_defaults :string_field => 'Hello Universe'
        end

        record = model.store_with_values
        record.string_field.should == 'Hello Universe'
      end

      it 'should allow setting associations' do
        associated_model = Model.create!

        record = Model.store_with_values(:associated_model => associated_model)
        record.reload
        record.associated_model.should == associated_model
      end

      it 'should allow setting primary keys' do
        record = Model.store_with_values(:id => 1337)
        record.id.should == 1337
      end

      it 'should create a record without running callbacks or validations' do
        model = Model.disposable_copy do
          before_save :crash
          validate :crash
          def crash
            raise 'callback was run'
          end
        end
        record = nil
        expect do
          record = model.store_with_values(:string_field => 'foo')
        end.to_not raise_error
        record.string_field.should == 'foo'
        record.should be_a(Model)
        record.id.should be_a(Fixnum)
        record.should_not be_new_record
      end

      it 'should work with single table inheritance' do
        child = StiChild.store_with_values(:string_field => 'foo')
        child.string_field.should == 'foo'
        child.should be_a(StiChild)
        child.id.should be_a(Fixnum)
        child.type.should == 'StiChild'
        child.should_not be_new_record
        StiChild.all.should == [child]
      end

    end

    describe '.create_without_callbacks' do

      it 'should print a deprecation warning urging to use .store_with_values instead' do
        Model.should_receive(:warn).with(/Use store_with_values instead/i)
        Model.should_receive(:store_with_values).with('args')
        Model.create_without_callbacks('args')
      end

    end

    describe '.new_and_store' do

      it 'should print a deprecation warning urging to use .store_with_values instead' do
        Model.should_receive(:warn).with(/Use store_with_values instead/i)
        Model.should_receive(:store_with_values).with('args')
        Model.new_and_store('args')
      end

    end

  end

end
