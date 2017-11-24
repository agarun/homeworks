class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions do |t|
      t.string :text, null: false
      t.integer :poll_id, null: false
      
      t.timestamps
    end
  end
end
