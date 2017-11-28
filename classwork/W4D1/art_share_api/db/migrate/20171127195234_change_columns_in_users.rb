class ChangeColumnsInUsers < ActiveRecord::Migration[5.1]
  def change
    remove_columns :users, :name, :email
    add_column :users, :username, :string
  end
end
