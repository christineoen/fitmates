class AddSignupZipToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.integer :signup_zip
    end
  end
end
