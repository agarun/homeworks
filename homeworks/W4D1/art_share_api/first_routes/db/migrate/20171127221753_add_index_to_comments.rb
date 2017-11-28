class AddIndexToComments < ActiveRecord::Migration[5.1]
  def change
    add_index :comments, :artwork_id
    add_index :comments, :user_id
  end
end
