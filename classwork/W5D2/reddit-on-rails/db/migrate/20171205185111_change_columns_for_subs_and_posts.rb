class ChangeColumnsForSubsAndPosts < ActiveRecord::Migration[5.1]
  def change
    remove_index :posts, column: [:sub_id]
    remove_column :posts, :sub_id
  end
end
