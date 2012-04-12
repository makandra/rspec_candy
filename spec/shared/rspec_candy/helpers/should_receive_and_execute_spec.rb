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

    end

  end

end
