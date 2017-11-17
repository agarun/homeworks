# O(n(n!)) time
# O(n!) space
def first_anagram?(str, target)
  anagrams = str.chars.permutation
  anagrams.include?(target.chars)
end

def first_anagram2?(str, target)
  # can similarly call `permutations`, defined recursively
end

def permutations(array)
  return [array] if array.size <= 1
  last_element = array[-1]
  previous_permutations = permutations(array[0...-1])

  total_permutations = []
  previous_permutations.each do |permutation|
    (permutation.size + 1).times do |i|
      total_permutations << (permutation[0...i] + [last_element] + permutation[i..-1])
    end
  end

  total_permutations
end

p first_anagram?("elvis", "lives")
p first_anagram?("gizmo", "sally")
p permutations("elvis".split("")).size == "elvis".split("").permutation.to_a.size # => true

# O(n^2) time
# O(n) space
def second_anagram?(str, target)
  chars1 = str.chars
  chars2 = target.chars

  chars1.each_with_index do |ch, i|
    target_idx = target.index(ch)
    return false if target_idx.nil?
    chars2[target_idx] = nil # or chars2.delete_at(target_idx), and remove `.compact`
  end

  chars2.compact.empty?
end

p second_anagram?("elvis", "lives")
p second_anagram?("gizmo", "sally")

# O(nlogn) time
# O(n) space?
def third_anagram?(str, target)
  str.chars.sort == target.chars.sort
end

p third_anagram?("elvis", "lives")
p third_anagram?("gizmo", "sally")

# O(n) time
# O(1) space
def fourth_anagram?(str, target)
  str_counts = Hash.new(0)
  target_counts = Hash.new(0)

  str.chars.each { |ch| str_counts[ch] += 1 }
  target.chars.each { |ch| target_counts[ch] += 1 }

  str_counts == target_counts
end

p fourth_anagram?("elvis", "lives")
p fourth_anagram?("gizmo", "sally")

# O(n) time
# O(1) space
def fourth_anagram2?(str, target)
  counts = Hash.new(0)

  str.chars.each { |ch| counts[ch] += 1 }
  target.chars.each { |ch| counts[ch] -= 1 }

  counts.values.all?(&:zero?)
end

p fourth_anagram2?("elvis", "lives")
p fourth_anagram2?("gizmo", "sally")
