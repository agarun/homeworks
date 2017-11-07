class Integer
  SMALL = {
    0 => "zero",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine",
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen",
    20 => "twenty",
    30 => "thirty",
    40 => "forty",
    50 => "fifty",
    60 => "sixty",
    70 => "seventy",
    80 => "eighty",
    90 => "ninety"
  }

  BIG = {
    100 => "hundred",
    1_000 => "thousand",
    1_000_000 => "million",
    1_000_000_000 => "billion",
    1_000_000_000_000 => "trillion"
  }

  def in_words
    num = self

    if num < 21
      return SMALL[num]
    elsif num < 100
      right = num % 10
      left = num - right

      if right.zero?
        return SMALL[left]
      else
        return [SMALL[left], right.in_words].join(" ")
      end
    else
      big_limit = 0
      BIG.each_key { |big| big_limit = big if big_limit < big && num >= big }

      right = num % big_limit
      left = num / big_limit

      if right.zero?
        return [left.in_words, BIG[big_limit]].join(" ")
      else
        return [left.in_words, BIG[big_limit], right.in_words].join(" ")
      end
    end
  end
end

# ~ concept
# if the number is 'big' (gt 99), process the 'big' portions
# and then recursively process the 'small' portions
# finally join strings by a space
#
# 234_421.in_words
# `consider 234` + 'thousand' + `consider 421`
