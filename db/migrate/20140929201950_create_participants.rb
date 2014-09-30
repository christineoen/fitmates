class CreateParticipants < ActiveRecord::Migration
  def change
    create_table :participants do |t|
      t.belongs_to :conversation
      t.belongs_to :user

      t.timestamps
    end
  end
end
