# (1)
class Array
  def my_transpose
    transposed = []

    (0...first.size).each do |cols|
      new_row = []

      (0...size).each do |rows|
        new_row << self[rows][cols]
      end

      transposed << new_row
    end

    transposed
  end
end

p [[1, 2], [3, 4]].my_transpose == [[1, 2], [3, 4]].transpose

# can't swap in this kind of matrix:
p [
  [1, 2],
  [3, 4],
  [5, 6]
].my_transpose == [[1, 2], [3, 4], [5, 6]].transpose
# => [[1, 3, 5], [2, 4, 6]]

# (2)
class Array
  def my_transpose
    Array.new(first.size) do |i|
      Array.new(size) do |j|
        self[j][i]
      end
    end
  end
end

p [[1, 2], [3, 4]].my_transpose == [[1, 2], [3, 4]].transpose

p [
  [1, 2],
  [3, 4],
  [5, 6]
].my_transpose #== [[1, 2], [3, 4], [5, 6]].transpose
# => [[1, 3, 5], [2, 4, 6]]
