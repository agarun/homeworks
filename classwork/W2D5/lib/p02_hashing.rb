class Fixnum
  # Fixnum#hash already implemented
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
    chars.map(&:ord).hash
  end
end

class Hash
  def hash
    hash_value = 1.hash

    self.each do |key, value|
      hash_value ^= (key.hash + (value.hash).hash)
    end

    hash_value
  end

  # to_a.sort_by(&:hash).hash # sort_by ignores order for hashes
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
