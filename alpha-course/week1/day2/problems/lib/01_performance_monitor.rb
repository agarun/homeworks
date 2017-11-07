def measure(number = 1, &block)
  start_time = Time.now # elapsed_time spec
  number.times { block.call(number) }
  end_time = Time.now
  (end_time - start_time) / number # average_time spec
end
