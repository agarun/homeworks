class Artist < ApplicationRecord
  has_many :albums,
    class_name: 'Album',
    foreign_key: :artist_id,
    primary_key: :id

  # count all of the tracks on each album by a given artist

  def n_plus_one_tracks
    albums = self.albums
    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end

  def better_tracks_query
    # joins > includes due to COUNT aggregate.
    # note we can also alias the `COUNT` and then refer to it in the `do end` block.
    # note `.count` would fire another query for each row
    albums = self
      .albums
      .select("albums.*, COUNT(*)")
      .joins(:tracks)
      .group("albums.id")

    tracks_count = {}
    albums.each do |album|
      tracks_count[album.title] = album.tracks.length
    end

    tracks_count
  end
end
