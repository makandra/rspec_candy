require 'spec_helper'

describe RSpecCandy::Helpers::DisposableCopy do

  describe Class do

    describe '.disposable_copy' do

      it 'should return a class' do
        Model.disposable_copy.should be_a(Class)
      end

      it 'should return a class with the same name as the original class' do
        Model.disposable_copy.name.should == 'Model'
      end

      it 'should return a class that instantiates objects that are also instances of the original class' do
        instance = Model.disposable_copy.new
        instance.should be_a(Model)
      end

      it 'should return a class that can be modified without changing the original class' do
        copy = Model.disposable_copy
        copy.class_eval do
          def foo
          end
        end
        copy.new.should respond_to(:foo)
        Model.new.should_not respond_to(:foo)
      end

      it 'should take a block with is evaluated in the context of the disposable class' do
        copy = Model.disposable_copy do
          def foo
          end
        end
        copy.new.should respond_to(:foo)
        Model.new.should_not respond_to(:foo)
      end

      it 'should evaluate the block after the copy has been renamed to the original class name' do
        spy = mock('spy')
        spy.should_receive(:observe_name).with('Model')
        Model.disposable_copy do
          spy.observe_name(name)
        end
      end

    end

  end

end
