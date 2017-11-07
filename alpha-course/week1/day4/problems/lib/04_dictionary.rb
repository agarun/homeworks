class Dictionary
  attr_reader :entries

  def initialize
    @entries = {}
  end

  def add(item)
    if item.is_a?(Hash)
      item.each { |k, v| @entries[k] = v }
    elsif item.is_a?(String)
      @entries[item] = nil
    end
  end

  def printable
    output = []

    @entries.each { |k, v| output << "[#{k}] \"#{v}\"" }

    output.reverse.join("\n")
  end

  def keywords
    @entries.keys.sort
  end

  def find(target)
    @entries.select { |k, v| k.include?(target) }
  end

  def include?(item)
    @entries.key?(item)
  end
end
