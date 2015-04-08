class Model < ActiveRecord::Base

  after_create :after_create_callback
  after_save :after_save_callback1, :after_save_callback2
  before_save :before_save_callback1, :before_save_callback2

  belongs_to :associated_model, :class_name => 'Model'

  if respond_to? :around_save
    around_save :around_save_callback1, :around_save_callback2
  end

  def after_create_callback; end
  def after_save_callback1; end
  def after_save_callback2; end
  def before_save_callback1; end
  def before_save_callback2; end
  def around_save_callback1; yield; end
  def around_save_callback2; yield; end

end


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


class StiParent < ActiveRecord::Base

  self.table_name = 'sti_models'

  before_save :crash
  validate :crash

  def crash
    raise 'callback was run'
  end

end


class StiChild < StiParent

end
