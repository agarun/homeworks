class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.boolean :private, default: false
      t.boolean :completed, default: false
      t.integer :user_id, null: false
      t.string :goal, null: false
      t.timestamps
    end
  end
end
