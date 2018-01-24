class Fixnum
  # Fixnum#hash already implemented for you
end

# each element should be associated with its index because order matters
class Array
  def hash
    hash_value = 0.hash

    self.each_with_index do |el, idx|
      hash_value ^= el.hash + idx
    end

    hash_value
  end
end

class String
  def hash
    chars.map(&:ord).hash
  end
end

# order doesn't matter here
class Hash
  # This returns 0 because rspec will break if it returns nil
  # Make sure to implement an actual Hash#hash method
  def hash
    # hash_value = 1.hash
    #
    # self.each do |key, value|
    #   hash_value ^= key.hash + (value.hash).hash
    # end

    self.to_a.sort_by(&:hash).hash
  end
end

# XOR
# 0 0 | 0
# 0 1 | 1
# 1 0 | 1
# 1 1 | 0
