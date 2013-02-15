class StiParent < ActiveRecord::Base

  self.table_name = 'sti_models'

  before_save :crash
  validate :crash

  def crash
    raise 'callback was run'
  end

end