# Octopus wants to eat the longest fish in an array of fish.

fish = ['fish', 'fiiish', 'fiiiiish', 'fiiiish', 'fffish', 'ffiiiiisshh', 'fsh', 'fiiiissshhhhhh']
# => "fiiiissshhhhhh"

# O(N^2)
def find_longest_fish(fish)
  (0...fish.size).each do |i|
    longest_fish = fish[i]

    (0...fish.size).each do |j|
      if longest_fish.length < fish[j].length
        longest_fish = nil
        break
      end
    end

    return longest_fish unless longest_fish.nil?
  end
end

p find_longest_fish(fish) # => "fiiiissshhhhhh"

# O(N log N)
def find_longest_fish(fish)
  sort_fish(fish).last
end

def sort_fish(fish)
  return fish if fish.size <= 1

  mid_idx = fish.size / 2
  small_fish = sort_fish(fish[0...mid_idx])
  big_fish = sort_fish(fish[mid_idx..-1])

  merge_fish(small_fish, big_fish)
end

def merge_fish(small_fish, big_fish)
  all_fish = []

  until small_fish.empty? || big_fish.empty?
    if small_fish.first.length < big_fish.first.length
      all_fish << small_fish.shift
    else
      all_fish << big_fish.shift
    end
  end

  all_fish + small_fish + big_fish
end

p find_longest_fish(fish) # => "fiiiissshhhhhh"

# O(N) linear
def find_longest_fish(fish)
  longest_fish = fish.first

  fish[1..-1].each do |fish|
    longest_fish = fish if longest_fish.length < fish.length
  end

  longest_fish
end

p find_longest_fish(fish) # => "fiiiissshhhhhh"

# The Octopus attempts Dance Dance Revolution.
# The game has tiles in the following directions:
tiles_array = ["up", "right-up", "right", "right-down", "down", "left-down", "left",  "left-up" ]

# To play the game, the octopus must step on a tile with her
# corresponding tentacle. We can assume that the octopus's eight
# tentacles are numbered and correspond to the tile direction indices.

# Slow Dance
#
# Given a tile direction, iterate through a tiles array to
# return the tentacle number (tile index) the octopus must move.

# O(n)
def slow_dance(direction, tiles)
  tiles.each_with_index { |tile, i| return i if tile == direction }
  nil
end
p slow_dance("up", tiles_array) # => 0
p slow_dance("right-down", tiles_array) # => 3

# Constant Dance!

# Now that the octopus is warmed up, let's help her dance faster.
# Use a different data structure and write a new function so that
# you can access the tentacle number in O(1) time.
tiles = %w[up right-up right right-down down left-down left left-up]
zipped = (0..7).to_a
new_tiles_data_structure = tiles.zip(zipped).to_h

# new_tiles_data_structure = {
#   "up" => 0,
#   "right-up" => 1,
#   "right" => 2,
#   "right-down" => 3,
#   "down" => 4,
#   "left-down" => 5,
#   "left" => 6,
#   "left-up" => 7
# }

def fast_dance(direction, tiles)
  tiles[direction]
end

p fast_dance("up", new_tiles_data_structure) # => 0
p fast_dance("right-down", new_tiles_data_structure) # => 3
