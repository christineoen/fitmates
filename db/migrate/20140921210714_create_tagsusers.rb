class CreateTagsusers < ActiveRecord::Migration
  def change
    create_table :tagsusers do |t|
      t.references :users
      t.references :tags
      
      t.timestamps
    end
  end
end
