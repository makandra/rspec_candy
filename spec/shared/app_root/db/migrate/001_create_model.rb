class CreateModel < ActiveRecord::Migration

  def self.up
    create_table :models do |t|
      t.string :string_field
      t.references :associated_model
    end
  end

  def self.down
    drop_table :models
  end
  
end
