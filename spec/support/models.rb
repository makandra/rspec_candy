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
