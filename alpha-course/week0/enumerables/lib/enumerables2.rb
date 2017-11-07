require 'byebug'

# EASY

# Define a method that returns the sum of all the elements in its argument (an
# array of numbers).
def array_sum(arr)
  arr.reduce(0, :+)
end

# Define a method that returns a boolean indicating whether substring is a
# substring of each string in the long_strings array.
# Hint: you may want a sub_string? helper method
def in_all_strings?(long_strings, substring)
  long_strings.all? { |string| string.include?(substring) }
end

# Define a method that accepts a string of lower case words (no punctuation) and
# returns an array of letters that occur more than once, sorted alphabetically.
def non_unique_letters(string)
  letter_counts = string.split.reduce(Hash.new(0)) do |counts, word|
    word.each_char { |ch| counts[ch] += 1 }
    counts
  end

  letter_counts.select { |ch, count| count > 1 }.keys
end

# def non_unique_letters(string)
#   string.chars.uniq.select { |ch| string.count(ch) > 1 if ch != " " } # O(n^2)?
# end

# Define a method that returns an array of the longest two words (in order) in
# the method's argument. Ignore punctuation!
def longest_two_words(string)
  string.delete("!?:;,.") # 'ignore punctuation'
  words = string.split
  words.max_by(2) { |word| word.length }
end

# MEDIUM

# Define a method that takes a string of lower-case letters and returns an array
# of all the letters that do not occur in the method's argument.
def missing_letters(string)
  ("a".."z").reject { |ch| string.include?(ch) }
end

# Define a method that accepts two years and returns an array of the years
# within that range (inclusive) that have no repeated digits. Hint: helper
# method?
def no_repeat_years(first_yr, last_yr)
  (first_yr..last_yr).select { |yr| not_repeat_year?(yr) }
end

def not_repeat_year?(year)
  year.to_s.chars == year.to_s.chars.uniq
end

# HARD

# Define a method that, given an array of songs at the top of the charts,
# returns the songs that only stayed on the chart for a week at a time. Each
# element corresponds to a song at the top of the charts for one particular
# week. Songs CAN reappear on the chart, but if they don't appear in consecutive
# weeks, they're "one-week wonders." Suggested strategy: find the songs that
# appear multiple times in a row and remove them. You may wish to write a helper
# method no_repeats?
# [b, a, b, b, c, b]
def one_week_wonders(songs)
  consecutive_weeks = []
  multi_weeks = []

  songs.each_with_index do |song, idx|
    if songs[idx] != songs[idx + 1]
      consecutive_weeks << song
    else
      multi_weeks << song
    end
  end

  (consecutive_weeks - multi_weeks).uniq
end

def no_repeats?(song_name, songs)
  # count appearances of song_name in songs
  # if count > 1, return false, else return true
  # then select unique songs that return true when called here (count <= 1)
end

# Define a method that, given a string of words, returns the word that has the
# letter "c" closest to the end of it. If there's a tie, return the earlier
# word. Ignore punctuation. If there's no "c", return an empty string. You may
# wish to write the helper methods c_distance and remove_punctuation.

def for_cs_sake(string)
  min_distance = Float::INFINITY

  string.delete!("!?:;,.'")
  string.split.reduce("") do |closest, word|
    distance = c_distance(word)

    if distance < min_distance
      min_distance = distance
      closest = word
    else
      closest
    end
  end
end

def c_distance(word)
  idx = word.rindex("c")
  word.length - 1 - idx.to_f # nil.to_f is 0.0
end

# Define a method that, given an array of numbers, returns a nested array of
# two-element arrays that each contain the start and end indices of whenever a
# number appears multiple times in a row. repeated_number_ranges([1, 1, 2]) =>
# [[0, 1]] repeated_number_ranges([1, 2, 3, 3, 4, 4, 4]) => [[2, 3], [4, 6]]

# hold on to the first_idx for a number
# if the next number is a repeat, keep looking for repeats
# else if the next number isn't a repeat, push first and last_idx to pairs & re-set first_idx
def repeated_number_ranges(arr)
  pairs = []
  first_idx = 0

  arr.each_index do |idx|
    next if idx == 0

    if arr[first_idx] != arr[idx]
      # set to idx of the new unique number
      first_idx = idx
    elsif arr[first_idx] != arr[idx + 1]
      # if the next num breaks the repeat
      pairs << [first_idx, idx]
    end
  end

  pairs
end

# def repeated_number_ranges(arr)
#   # if we find a range (current el equal to next el), then declare the
#   # first_idx to the current_idx. add a condition to only do this if first_idx
#   # wasn't declared already, since ranges might be > 2 elements
#   # if we find the end of a range (current el not equal to next el), then
#   # add [first_idx, idx] to pairs and reset first_idx to nil
#   pairs = []
#   first_idx = nil
#
#   arr.each_index do |idx|
#     if arr[idx] == arr[idx + 1]
#       first_idx = idx unless first_idx
#     elsif first_idx # only enter here if we found a repeat sequence earlier
#       pairs << [first_idx, idx]
#       first_idx = nil
#     end
#   end
#
#   pairs
# end
