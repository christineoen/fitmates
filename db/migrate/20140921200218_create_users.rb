class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.integer :age
      t.text :description
      
      t.timestamps
    end
  end
end
