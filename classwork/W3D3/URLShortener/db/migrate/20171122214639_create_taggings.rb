class CreateTaggings < ActiveRecord::Migration[5.1]
  def change
    create_table :taggings do |t|
      t.integer :tag_topic_id
      t.integer :shortened_url_id
      
      t.timestamps
    end
    
    add_index :taggings, :tag_topic_id
    add_index :taggings, :shortened_url_id
  end
end
