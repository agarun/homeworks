# Options Hashes
#
# Write a method `transmogrify` that takes a `String`. This method should
# take optional parameters `:times`, `:upcase`, and `:reverse`. Hard-code
# reasonable defaults in a `defaults` hash defined in the `transmogrify`
# method. Use `Hash#merge` to combine the defaults with any optional
# parameters passed by the user. Do not modify the incoming options
# hash. For example:
#
# ```ruby
# transmogrify("Hello")                                    #=> "Hello"
# transmogrify("Hello", :times => 3)                       #=> "HelloHelloHello"
# transmogrify("Hello", :upcase => true)                   #=> "HELLO"
# transmogrify("Hello", :upcase => true, :reverse => true) #=> "OLLEH"
#
# options = {}
# transmogrify("hello", options)
# # options shouldn't change.
# ```

def transmogrify(string, options={})
  defaults = {
    times: nil,
    upcase: false,
    reverse: false
  }

  options = defaults.merge(options)

  new_string = string[0..-1]
  new_string.upcase! if options[:upcase]
  new_string.reverse! if options[:upcase]
  # only create a new string object if the value for `:times` isn't falsey
  new_string * options[:times] if options[:times]
end

# foo = "a"
# > foo.object_id
# => 26057060
# > (foo * 1).object_id
# => 26350400
