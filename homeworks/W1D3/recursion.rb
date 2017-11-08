# Write a function sum_to(n) that uses recursion to
# calculate the sum from 1 to n (inclusive of n).
#                        *

def sum_to(n)
  if n < 0
    nil # 'sum from 1 to n'
  elsif n.zero?
    0
  else
    n + sum_to(n - 1)
  end
end

p "`sum_to` tests (exercise 1)"
p sum_to(5) == 15
p sum_to(1) == 1
p sum_to(9) == 45
p sum_to(-8) == nil

# Write a function add_numbers(nums_array) that takes in an array of Fixnums
# and returns the sum of those numbers. Write this method recursively.

def add_numbers(nums_array)
  if nums_array.size <= 1
    nums_array.first
  else
    nums_array.first + add_numbers(nums_array[1..-1])
  end
end

p "`add_numbers` tests (exercise 2)"
p add_numbers([1, 2, 3, 4]) == 10
p add_numbers([3]) == 3
p add_numbers([-80, 34, 7]) == -39
p add_numbers([]) == nil # [].first => nil

# Let's write a method that will solve Gamma Function recursively.
# The Gamma Function is defined Γ(n) = (n-1)!

def gamma_fnc(n)
  if (n - 1) < 0
    nil
  elsif (n - 1).zero?
    1
  else
    (n - 1) * gamma_fnc(n - 1)
  end
end

p "`gamma_fnc` tests (exercise 3)"
p gamma_fnc(0) == nil
p gamma_fnc(1) == 1
p gamma_fnc(4) == 6
p gamma_fnc(8) == 5040

# Write a function ice_cream_shop(flavors, favorite) that takes in an array of
# ice cream flavors available at the ice cream shop,
# as well as the user's favorite ice cream flavor.
# Recursively find out whether or not the shop offers their favorite flavor.

def ice_cream_shop(flavors, favorite)
  if flavors.empty?
    false
  elsif flavors.first == favorite
    true
  else
    ice_cream_shop(flavors[1..-1], favorite)
  end
end

p "`ice_cream_shop` tests (exercise 4)"
p ice_cream_shop(['vanilla', 'strawberry'],
               'blue moon') == false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'],
               'green tea') == true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'],
               'pistachio') == false
p ice_cream_shop(['moose tracks'],
               'moose tracks') == true
p ice_cream_shop([],
               'honey lavender') == false

# Write a function `reverse(string)` that takes in a string and returns it reversed

def reverse(string)
  return string if string.empty?
  string[-1] + reverse(string[0..-2])
end

p "`reverse` tests (exercise 5)"
p reverse("house") == "esuoh"
p reverse("dog") == "god"
p reverse("atom") == "mota"
p reverse("q") == "q"
p reverse("id") == "di"
p reverse("") == ""
