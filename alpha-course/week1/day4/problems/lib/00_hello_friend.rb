class Friend
  def greeting(name = "", phrase = "Hello")
    name.length > 0 ? "#{phrase}, #{name}!" : "#{phrase}!"
  end

  def greeting2(name = nil)
    "Hello#{', ' + name if name}!"
  end
end
