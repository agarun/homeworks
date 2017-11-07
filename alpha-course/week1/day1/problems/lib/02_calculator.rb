def add(n, m)
  n + m
end

def subtract(n, m)
  n - m
end

def sum(numbers)
  numbers.reduce(0, :+)
end

def multiply(numbers)
  numbers.reduce(:*)
end

def factorial(n)
  return 1 if n == 0
  n * factorial(n - 1)
end

def factorial(n)
  return 1 if n == 0
  (1..n).reduce(:*)
end

def power(number, exponent)
  number**exponent
end
