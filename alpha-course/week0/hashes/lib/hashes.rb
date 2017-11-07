# EASY

# Define a method that, given a sentence, returns a hash of each of the words as
# keys with their lengths as values. Assume the argument lacks punctuation.
def word_lengths(str)
  str.split.reduce({}) do |hsh, word|
    hsh[word] = word.length
    hsh
  end
end

# Define a method that, given a hash with integers as values, returns the key
# with the largest value.
def greatest_key_by_val(hash)
  hash.sort_by { |k, v| v }.last.first
end

# Define a method that accepts two hashes as arguments: an older inventory and a
# newer one. The method should update keys in the older inventory with values
# from the newer one as well as add new key-value pairs to the older inventory.
# The method should return the older inventory as a result. march = {rubies: 10,
# emeralds: 14, diamonds: 2} april = {emeralds: 27, moonstones: 5}
# update_inventory(march, april) => {rubies: 10, emeralds: 27, diamonds: 2,
# moonstones: 5}
def update_inventory(older, newer)
  newer.each { |k, v| older[k] = v }
  older
end

# Define a method that, given a word, returns a hash with the letters in the
# word as keys and the frequencies of the letters as values.
def letter_counts(word)
  counts = Hash.new(0)
  word.each_char { |ch| counts[ch] += 1 }
  counts
end

# MEDIUM

# Define a method that, given an array, returns that array without duplicates.
# Use a hash! Don't use the uniq method.
def my_uniq(arr)
  uniques = {}
  arr.each { |el| uniques[el] = true }
  uniques.keys
end

# Define a method that, given an array of numbers, returns a hash with :even
# and :odd as keys and the frequency of each parity as values.
def evens_and_odds(numbers)
  parity = Hash.new(0)
  numbers.each { |n| n.even? ? parity[:even] += 1 : parity[:odd] += 1 }
  parity
end

# Define a method that, given a string, returns the most common vowel. If
# there's a tie, return the vowel that occurs earlier in the alphabet. Assume
# all letters are lower case.
def most_common_vowel(string)
  letter_counts = Hash.new(0)
  string.each_char { |ch| letter_counts[ch] += 1 }

  vowel_counts = letter_counts.select { |ch, count| "aeiou".include?(ch) }
  vowel_counts
    .to_a # conver to nested arr of arrs
    .sort # sort by letter
    .max_by { |pair| pair.last } # max by count
    .first # key (letter)
end

# HARD

# Define a method that, given a hash with keys as student names and values as
# their birthday months (numerically, e.g., 1 corresponds to January), returns
# every combination of students whose birthdays fall in the second half of the
# year (months 7-12). students_with_birthdays = { "Asher" => 6, "Bertie" => 11,
# "Dottie" => 8, "Warren" => 9 }
# fall_and_winter_birthdays(students_with_birthdays) => [ ["Bertie", "Dottie"],
# ["Bertie", "Warren"], ["Dottie", "Warren"] ]
# [b, d, w]
def fall_and_winter_birthdays(students)
  second_half = students.select { |name, month| month > 6 }

  name_pairs = []

  second_half_names = second_half.keys
  second_half_names.each_with_index do |name, i|
    second_half_names[i + 1..-1].each do |partner|
      name_pairs << [name, partner]
    end
  end

  name_pairs
end

# Define a method that, given an array of specimens, returns the biodiversity
# index as defined by the following formula: number_of_species**2 *
# smallest_population_size / largest_population_size
# biodiversity_index(["cat", "cat", "cat"]) => 1
# biodiversity_index(["cat", "leopard-spotted ferret",
# "dog"]) => 9
def biodiversity_index(specimens)
  number_of_species = specimens.uniq.size
  smallest_pop_sz, largest_pop_sz = specimens.map { |spec| specimens.count(spec) }.minmax

  number_of_species**2 * smallest_pop_sz / largest_pop_sz
end

# Define a method that, given the string of a respectable business sign, returns
# a boolean indicating whether pranksters can make a given vandalized string
# using the available letters. Ignore capitalization and punctuation.
# can_tweak_sign("We're having a yellow ferret sale for a good cause over at the
# pet shop!", "Leopard ferrets forever yo") => true
def can_tweak_sign?(normal_sign, vandalized_sign)
  normal = ignore_punct(normal_sign)
  vandal = ignore_punct(vandalized_sign)

  normal_counts = character_count(normal)
  vandal_counts = character_count(vandal)

  normal_counts.each { |letter, count| return false if count < vandal_counts[letter] }
  true
end

def character_count(str)
  count = Hash.new(0)
  str.chars.each { |ch| count[ch] += 1 }
  count
end

def ignore_punct(str)
  str.downcase.delete("!?:;,. ")
end
