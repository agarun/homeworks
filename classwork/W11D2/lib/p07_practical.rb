require_relative 'p05_hash_map'

def can_string_be_palindrome?(string)
  counter_hash = HashMap.new

  # i didn't do a feature for a default value
  string.chars.each do |ch|
    if counter_hash[ch]
      counter_hash[ch] += 1
    else
      counter_hash[ch] = 1
    end
  end

  # return false if there is an odd count (otherwise return true at the end)
  # return false if more than one item has an odd count !

  num_odds = 0
  counter_hash.each do |_, val|
    num_odds += 1 if val.odd?
  end

  if string.length.even?
    return false if num_odds > 0
  elsif num_odds > 1
    return false
  end

  true
end
