class AddIndexToPeople < ActiveRecord::Migration[5.1]
  def change
    add_index :people, :house_id
  end
end
