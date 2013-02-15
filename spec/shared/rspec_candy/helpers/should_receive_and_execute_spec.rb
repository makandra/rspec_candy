require 'spec_helper'

describe RSpecCandy::Helpers::ShouldReceiveAndExecute do

  describe Object do

    describe '#should_receive_and_execute' do

      it 'should not stub away the original method implementation' do
        object = "object"
        object.should_receive_and_execute(:size)
        object.size.should == 6
      end

      it 'should set an expectation that the given method are called' do
        (<<-example).should fail_as_example
          object = 'object'
          object.should_receive_and_execute(:size)
        example
      end

      it 'should return the expectation for further parameterization' do
        object = 'object'
        object.should_receive_and_execute(:size).class.name.should include('MessageExpectation')
        object.size # make the example pass
      end

      it "should not overwrite the implementation of a class method defined through an object's singleton class" do
        object = Object.new
        def object.foo
          'foo'
        end
        object.should_receive_and_execute(:foo)
        object.foo.should == 'foo'
      end

      it 'should not fail for a class that responds to messages using #method_missing' do
        klass = Class.new do
          def respond_to?(*args)
            true
          end
          def method_missing(symbol, *args, &block)
            'foo'
          end
        end
        object = klass.new
        object.should_receive_and_execute(:foo)
        object.foo.should == 'foo'
      end

    end

  end

end
