def reverser(&block)
  string = yield
  string.split.map(&:reverse).join(" ")
end

def adder(value = 1, &block)
  yield + value
end

def repeater(number = 1, &block)
  number.times { yield }
end
