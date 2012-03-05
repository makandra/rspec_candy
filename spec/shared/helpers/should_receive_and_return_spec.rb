require 'spec_helper'

describe RSpecCandy::Helpers::StubExisting do

  describe Object do

    describe '#should_receive_and_return' do

      it 'should stub out the given methods with the given return values' do
        object = 'object'
        object.should_receive_and_return(:foo => 'foo', :bar => 'bar')
        object.foo.should == 'foo'
        object.bar.should == 'bar'
        object.size.should == 6 # object still responds to unstubbed methods
      end

      it 'should set expectations that all given methods are called' do
        (<<-example).should fail_as_example
          object = 'object'
          object.should_receive_and_return(:foo => 'foo', :bar => 'bar')
          object.foo
          # but not object.bar
        example
      end

    end

  end

end
