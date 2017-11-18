class Fixnum
  # Fixnum#hash already implemented for you
end

class Array
  def hash
    hash_value = 0.hash

    self.each_with_index do |el, idx|
      hash_value ^= (el.hash + idx)
    end

    hash_value
  end
end

class String
  def hash
    string_vals = self.chars.map { |char| char.ord } # map(&:ord)
    string_vals.hash
  end
end

class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    hash_value = 1.hash

    self.each do |key, value|
      hash_value ^= (key.hash + (value.hash).hash)
    end

    hash_value
  end
end

# p [1,2,3].hash
# p [3,2,1].hash
# p [1,2,3].hash == [3,0,3].hash

# p "hey".hash == "hye".hash

# p [1, 3, [4], ["abc"]].hash == [1, 3, ["abc"], [4]].hash
# p [1, 3, [4], ["abc"]].hash
# p [1, 3, ["abc"], [4]].hash

# hash1 = {2 => "a"}
# hash2 = {"a" => 2}
# p hash1.hash == hash2.hash
