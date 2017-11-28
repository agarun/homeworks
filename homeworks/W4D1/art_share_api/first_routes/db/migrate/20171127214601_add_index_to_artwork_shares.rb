class AddIndexToArtworkShares < ActiveRecord::Migration[5.1]
  def change
    add_index :artwork_shares, [:artwork_id, :viewer_id], unique: true
  end
end
