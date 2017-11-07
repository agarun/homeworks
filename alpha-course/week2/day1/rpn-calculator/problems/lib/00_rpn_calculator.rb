class RPNCalculator
  def initialize
    @stack = []
  end

  def push(number)
    @stack << number
  end

  def plus
    operator(:+)
  end

  def minus
    operator(:-)
  end

  def divide
    operator(:/)
  end

  def times
    operator(:*)
  end

  def value
    @stack.last
  end

  def tokens(string)
    operators = %w[+ - / *]
    string.split.map { |token| operators.include?(token) ? token.to_sym : token.to_i }
  end

  def evaluate(string)
    tokens(string).each do |token|
      if token.is_a?(Integer)
        push(token)
      else
        operator(token)
      end
    end

    value
  end

  private

  def operator(token)
    if @stack.size < 2
      raise "calculator is empty"
    else
      right, left = @stack.pop, @stack.pop
      @stack << left.send(token, right.to_f)
    end
  end
end
