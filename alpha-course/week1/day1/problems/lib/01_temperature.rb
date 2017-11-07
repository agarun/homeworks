# "one degree fahrenheit is 5/9 of one degree celsius,
# and the freezing point of water is 0 degrees celsius but 32
# degrees fahrenheit."
# => so to get F from C, C * 9/5 and add 32
# e.g. 0 * 9/5 + 32 = 32
# that is, F = C * (9 / 5) + 32
# thus C = (5 / 9) * (F - 32)

def ftoc(degrees)
  (5 / 9.0) * (degrees - 32)
end

def ctof(degrees)
  (9 / 5.0) * degrees + 32
end
