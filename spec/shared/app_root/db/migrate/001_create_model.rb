class CreateModel < ActiveRecord::Migration

  def self.up
    create_table :models do |t|
    end
  end

  def self.down
    drop_table :models
  end
  
end
