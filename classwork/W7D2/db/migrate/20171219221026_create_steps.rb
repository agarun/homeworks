class CreateSteps < ActiveRecord::Migration[5.1]
  def change
    create_table :steps do |t|
      t.string :description, null: false
      t.integer :todo_id, null: false

      t.timestamps
    end

    add_index :steps, :todo_id

  end
end
