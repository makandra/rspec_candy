require 'spec_helper'

describe RSpecCandy::Helpers::Rails::CreateWithoutCallbacks do

  describe ActiveRecord::Base do

    describe '.create_without_callbacks' do

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
          record = model.create_without_callbacks(:string_field => 'foo')
        end.to_not raise_error
        record.string_field.should == 'foo'
        record.should be_a(Model)
        record.id.should be_a(Fixnum)
        record.should_not be_new_record
      end

    end

    describe '.new_and_store' do

      it 'should print a deprecation warning urging to use .create_without_callbacks instead' do
        Model.should_receive(:warn).with(/Use create_without_callbacks instead/i)
        Model.should_receive(:create_without_callbacks).with('args')
        Model.new_and_store('args')
      end

    end

  end

end
