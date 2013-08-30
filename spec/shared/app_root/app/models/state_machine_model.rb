class StateMachineModel < ActiveRecord::Base

  if respond_to?(:state_machine)

    state_machine :initial => :state1 do

      state :state1

      state :state2

      state :state3

      event :event do
        transition :state1 => :state2
      end

      event :another_event do
        transition :state1 => :state3
      end

      after_transition :state1 => :state2, :do => :event_callback

    end

    state_machine :custom_state, :initial => :state1 do

      state :state1

      state :state2

      state :state3

      event :event do
        transition :state1 => :state2
      end

      event :another_event do
        transition :state1 => :state3
      end

      after_transition :state1 => :state2, :do => :custom_state_event_callback

    end

    def event_callback
    end

    def custom_state_event_callback
    end

  end

end
