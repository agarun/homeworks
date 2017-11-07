def echo(string)
  string
end

def shout(string)
  string.upcase
end

def repeat(string, n = 2)
  string << " "
  (string * n)[0...-1]
end

def repeat(string, times = 2)
  words = Array.new(times, string)
  words.join(" ")
end

def start_of_word(string, n)
  string[0...n]
end

def first_word(string)
  string.split.first
end

def titleize(string)
  little_words = %w[and over the]

  caps = string.split.map.with_index do |word, i|
    little_words.include?(word) && i != 0 ? word : word.capitalize
  end

  caps.join(" ")
end
