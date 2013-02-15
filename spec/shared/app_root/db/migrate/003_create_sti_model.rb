class CreateStiModel < ActiveRecord::Migration

  def self.up
    create_table :sti_models do |t|
      t.string :type
      t.string :string_field
    end
  end

  def self.down
    drop_table :sti_models
  end

end
