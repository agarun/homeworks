require "byebug"

class Array
  def my_each
    length.times do |i|
      yield(self[i])
    end

    self
  end

  def my_select
    selected = []

    self.my_each { |el| selected << el if yield(el) }

    selected
  end

  def my_reject
    selected = []

    self.my_each { |el| selected << el unless yield(el) }

    selected
  end

  def my_any?
    self.my_each { |el| return true if yield(el) }
    false
  end

  # e.g. [1, 2, 3, [4, [5, 6]], [[[7]], 8]]
  def my_flatten
    flattened = []

    my_each do |el|
      if el.is_a?(Array)
        flattened.concat(el.my_flatten)
      else
        flattened << el
      end
    end

    flattened
  end

  # a = [ 4, 5, 6 ]
  # b = [ 7, 8, 9 ]
  # [1, 2, 3].my_zip(a, b) # => [[1, 4, 7], [2, 5, 8], [3, 6, 9]]
  # a.my_zip([1,2], [8])   # => [[4, 1, 8], [5, 2, nil], [6, nil, nil]]
  # [1, 2].my_zip(a, b)    # => [[1, 4, 7], [2, 5, 8]]
  #
  # c = [10, 11, 12]
  # d = [13, 14, 15]
  # [1, 2].my_zip(a, b, c, d)    # => [[1, 4, 7, 10, 13], [2, 5, 8, 11, 14]]

  def my_zip(*args)
    zipped = []

    0.upto(self.length - 1) do |i|
      sub_array = [self[i]]
      args.each { |array| sub_array << array[i] }
      zipped << sub_array
    end

    zipped
  end

  # a = [ "a", "b", "c", "d" ]
  # a.my_rotate         #=> ["b", "c", "d", "a"]
  # a.my_rotate(2)      #=> ["c", "d", "a", "b"]
  # a.my_rotate(-3)     #=> ["b", "c", "d", "a"]
  # a.my_rotate(15)     #=> ["d", "a", "b", "c"]

  def my_rotate(offset = 1)
    offset %= self.length
    self.drop(offset) + self.take(offset)
  end

  # a = [ "a", "b", "c", "d" ]
  # a.my_join         # => "abcd"
  # a.my_join("$")    # => "a$b$c$d"
  def my_join(separator = "")
    result = ""

    length.times do |i|
      result << self[i].to_s
      result << separator unless i == length - 1
    end

    result
  end

  # [ "a", "b", "c" ].my_reverse   #=> ["c", "b", "a"]
  # [ 1 ].my_reverse               #=> [1]
  def my_reverse
    reversed = []

    (self.length - 1).downto(0) do |i|
      reversed << self[i]
    end

    reversed
  end
end

# Factors
#
# Write a method `factors(num)` that returns an array containing all the
# factors of a given number.

def factors(num)
  (1..num).select { |n| num % n == 0 }
end

# Bubble Sort
#
# http://en.wikipedia.org/wiki/bubble_sort
#
# Implement Bubble sort in a method, `Array#bubble_sort!`. Your method should
# modify the array so that it is in sorted order.

class Array
  def bubble_sort!(&prc)
    sorted = false

    until sorted
      sorted = true

      self.each_with_index do |num, idx|
        next_num = self[idx + 1]

        if prc.call(num, next_num) == 1
          self[idx], self[idx + 1] = self[idx + 1], self[idx]
          sorted = false
        end
      end
    end

    self
  end

  def bubble_sort(&prc)
    self.dup.bubble_sort!(&prc)
  end
end

# Substrings and Subwords

def substrings(string)
  result = []
  string.chars.each_index do |i|
    (i...string.length).each do |j|
      result << string[i..j]
    end
  end
  result
end

def subwords(word, dictionary)
  substrings(word).select { |wd| dictionary.include?(wd) }
end
