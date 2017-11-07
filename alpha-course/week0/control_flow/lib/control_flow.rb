# EASY

# Return the argument with all its lowercase characters removed.
def destructive_uppercase(str)
  str.each_char { |ch| str.delete!(ch) if ch == ch.downcase }
end

# Return the middle character of a string. Return the middle two characters if
# the word is of even length, e.g. middle_substring("middle") => "dd",
# middle_substring("mid") => "i"
def middle_substring(str)
  mid_idx = str.length / 2

  if str.length.even?
    str[mid_idx - 1..mid_idx]
  else
    str[mid_idx]
  end
end

# Return the number of vowels in a string.
VOWELS = %w(a e i o u)
def num_vowels(str)
  str.count(VOWELS.join)
end

# Return the factoral of the argument (num). A number's factorial is the product
# of all whole numbers between 1 and the number itself. Assume the argument will
# be > 0.
def factorial(num)
  (1..num).reduce(:*)
end

def factorial(num)
  num == 1 ? 1 : num * factorial(num - 1)
end

# MEDIUM

# Write your own version of the join method. separator = "" ensures that the
# default seperator is an empty string.
def my_join(arr, separator = "")
  result = ""

  arr.each_with_index do |el, idx|
    result << el
    result << separator unless idx == arr.size - 1
  end

  result
end

# Write a method that converts its argument to weirdcase, where every odd
# character is lowercase and every even is uppercase, e.g.
# weirdcase("weirdcase") => "wEiRdCaSe"
def weirdcase(str)
  str
    .chars
    .each_with_index { |ch, i| str[i] = (i + 1).odd? ? ch.downcase : ch.upcase }
  str
end

# Reverse all words of five or more letters in a string. Return the resulting
# string, e.g., reverse_five("Looks like my luck has reversed") => "skooL like
# my luck has desrever")
def reverse_five(str)
  arr = str.split
  arr.each { |word| word.reverse! if word.length >= 5 }
  arr.join(" ")
end

# Return an array of integers from 1 to n (inclusive), except for each multiple
# of 3 replace the integer with "fizz", for each multiple of 5 replace the
# integer with "buzz", and for each multiple of both 3 and 5, replace the
# integer with "fizzbuzz".
def fizzbuzz(n)
  (1..n).to_a.map do |num|
    if num % 15 == 0
      "fizzbuzz"
    elsif num % 3 == 0
      "fizz"
    elsif num % 5 == 0
      "buzz"
    else
      num
    end
  end
end

def fizzbuzz(n)
  (1..n).to_a.map do |num|
    case num % 15
    when 0
      "fizzbuzz"
    when 3, 6, 9, 12
      "fizz"
    when 5, 10
      "buzz"
    else
      num
    end
  end
end

# HARD

# Write a method that returns a new array containing all the elements of the
# original array in reverse order.
# 1, 2, 3, 4
def my_reverse(arr)
  (arr.length / 2).times { |i| arr[i], arr[-i - 1] = arr[-i - 1], arr[i] }
  arr
end

def my_reverse(arr)
  backwards = []

  arr.each { |el| backwards.unshift(el) }

  backwards
end

# Write a method that returns a boolean indicating whether the argument is
# prime.
def prime?(num)
  return false if num == 1
  # `Math.sqrt(num)` because the greatest factor can be the sqrt, since sqrt(n)**2 = n
  (2..Math.sqrt(num)).none? { |n| num % n == 0 }
end

# Write a method that returns a sorted array of the factors of its argument.
def factors(num)
  (1..num).select { |n| num % n == 0 }
end

# Write a method that returns a sorted array of the prime factors of its argument.
def prime_factors(num)
  factors(num).select { |n| prime?(n) }
end

# Write a method that returns the number of prime factors of its argument.
def num_prime_factors(num)
  prime_factors(num).size
end

# EXPERT

# Return the one integer in an array that is even or odd while the rest are of
# opposite parity, e.g. oddball([1,2,3]) => 2, oddball([2,4,5,6] => 5)
def oddball(arr)
  even = []
  odd = []

  arr.each { |n| n.even? ? even << n : odd << n }

  even.size == 1 ? even.first : odd.first
end

def oddball(arr)
  parity = Hash.new([])

  arr.each_with_index do |num, idx|
    num.even? ? parity['even'] += [idx] : parity['odd'] += [idx]
  end

  parity['even'].size == 1 ? arr[parity['even'][0]] : arr[parity['odd'][0]]
end
