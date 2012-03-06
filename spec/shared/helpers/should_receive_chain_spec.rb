require 'spec_helper'

describe RSpecCandy::Helpers::ShouldReceiveChain do

  describe Object do

    describe '#should_receive_chain' do

      it "should pass when the chain was traversed completely" do
        (<<-example).should pass_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message)
          object.first_message.second_message
        example
      end

      it "should fail when the chain wasn't traversed at all" do
        (<<-example).should fail_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message)
        example
      end

      it "should fail when the chain was only traversed partially" do
        (<<-example).should fail_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message)
          object.first_message
        example
      end

      it "should allow to add argument expectations to inner chain links by using array notation" do
        (<<-example).should pass_as_example
          object = "object"
          object.should_receive_chain([:first_message, 'argument'], :second_message)
          object.first_message('argument').second_message
        example
        (<<-example).should fail_as_example
          object = "object"
          object.should_receive_chain([:first_message, 'argument'], :second_message)
          object.first_message('wrong argument').second_message
        example
      end

      it "should allow to add argument expectations to the last chain link by using regular should_receive options" do
        (<<-example).should pass_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message).with('argument')
          object.first_message.second_message('argument')
        example
        (<<-example).should fail_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message).with('argument')
          object.first_message.second_message('wrong argument')
        example
      end

      it 'should allow inner chain links to be called more than once' do
        (<<-example).should pass_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message)
          object.first_message
          object.first_message.second_message
        example
      end

    end


    describe '#should_not_receive_chain' do

      it "should pass when the chain was traversed completely" do
        (<<-example).should fail_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message)
          object.first_message.second_message
        example
      end

      it "should pass when the chain wasn't traversed at all" do
        (<<-example).should fail_as_example
          object = "object"
          object.should_not_receive_chain(:first_message, :second_message)
        example
      end

      it "should pass when the chain was only traversed partially" do
        (<<-example).should pass_as_example
          object = "object"
          object.should_receive_chain(:first_message, :second_message)
          object.first_message
        example
      end

    end

  end

end
