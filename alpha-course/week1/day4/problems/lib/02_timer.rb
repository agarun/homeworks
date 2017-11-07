class Timer
  attr_accessor :seconds

  def initialize
    @seconds = 0
  end

  def time_string
    seconds = @seconds % 60
    minutes = @seconds / 60 % 60
    hours   = @seconds / 60 / 60

    "#{pad(hours)}:#{pad(minutes)}:#{pad(seconds)}"
  end

  private

  def pad(item)
    item.to_s.rjust(2, "0")
  end
end

# e.g. 66 seconds
# seconds = 66 % 60 = 6
# minutes = 66 / 60 % 60 = 1
# hours   =  1 / 60 / 60 = 0
