ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => ':memory:')

ActiveRecord::Migration.class_eval do

  create_table :models do |t|
    t.string :string_field
    t.references :associated_model
  end

  create_table :sti_models do |t|
    t.string :type
    t.string :string_field
  end

end
