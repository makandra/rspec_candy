require 'spec_helper'

describe RSpecCandy::Helpers::NewWithStubs do

  describe Class do

    describe '#new_with_stubs'

    it 'should instantiate a class with an empty constructor and stub out the given methods' do
      klass = Class.new do
        def initialize
        end
        def foo
          'stubbed foo'
        end
        def bar
          'unstubbed bar'
        end
        def unstubbed_method
          'unstubbed result'
        end
      end
      instance = klass.new_with_stubs(:foo => 'stubbed foo', :bar => 'stubbed bar')
      instance.foo.should == 'stubbed foo'
      instance.bar.should == 'stubbed bar'
      instance.unstubbed_method.should == 'unstubbed result'
    end

    it 'should raise an error when trying to stub non-existing methods' do
      klass = Class.new do
        def initialize
        end
      end
      expect do
        klass.new_with_stubs(:foo => 'foo')
      end.to raise_error(/Attempted to stub non-existing method/)
    end

  end

end