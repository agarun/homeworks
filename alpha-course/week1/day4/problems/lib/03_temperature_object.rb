# Remember that one degree fahrenheit is 5/9 of one degree celsius,
# and that the freezing point of water is 0 degrees celsius but 32
# degrees fahrenheit.
# i.e. to get F from C, multiply C by (9 / 5) and add 32

class Temperature
  # self is Temperature because this is a class method
  def self.from_fahrenheit(temp)
    self.new(f: temp)
  end

  def self.from_celsius(temp)
    self.new(c: temp)
  end

  def self.ftoc(temp)
    (temp - 32) * (5 / 9.0)
  end

  def self.ctof(temp)
    temp * (9 / 5.0) + 32
  end

  def initialize(temp)
    if temp[:f]
      self.fahrenheit = temp[:f] # converts temperature to fahrenheit using custom setter
    else
      self.celsius = temp[:c] # stores temperature as celsius using custom setter
    end
  end

  # in the setter methods called by the `new` method,
  # consider celisus to be the default temp, so convert if fahrenheit was fed in
  def fahrenheit=(temp)
    @temp = self.class.ftoc(temp) # converts temperature to fahrenheit
  end

  def celsius=(temp)
    @temp = temp # stores temperature as celsius
  end

  def in_fahrenheit
    self.class.ctof(@temp) # since we stored temp as celsius, must convert back
  end

  def in_celsius
    @temp # since we stored temp as celsius, deliver it back
  end
end

# identically, celsius is considered the 'default' because initialization is
# forwarded to the setter methods in `Temperature` (able to access because extending superclass)
class Fahrenheit < Temperature
  def initialize(temp)
    self.fahrenheit = temp
  end
end

class Celsius < Temperature
  def initialize(temp)
    self.celsius = temp
  end
end
