class CreateStateMachineModel < ActiveRecord::Migration

  def self.up
    create_table :state_machine_models do |t|
      t.string :state
    end
  end

  def self.down
    drop_table :state_machine_models
  end
  
end
