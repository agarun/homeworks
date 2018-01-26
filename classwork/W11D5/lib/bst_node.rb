# access and set @value in constant time

class BSTNode
  attr_reader :value
  attr_accessor :left, :right, :parent

  def initialize(value)
    @value = value
  end
end
