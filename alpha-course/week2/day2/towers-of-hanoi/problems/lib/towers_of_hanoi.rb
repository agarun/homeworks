# Towers of Hanoi
#
# Write a Towers of Hanoi game:
# http://en.wikipedia.org/wiki/Towers_of_hanoi
#
# In a class `TowersOfHanoi`, keep a `towers` instance variable that is an array
# of three arrays. Each subarray should represent a tower. Each tower should
# store integers representing the size of its discs. Expose this instance
# variable with an `attr_reader`.
#
# You'll want a `#play` method. In a loop, prompt the user using puts. Ask what
# pile to select a disc from. The pile should be the index of a tower in your
# `@towers` array. Use gets
# (http://andreacfm.com/2011/06/11/learning-ruby-gets-and-chomp.html) to get an
# answer. Similarly, find out which pile the user wants to move the disc to.
# Next, you'll want to do different things depending on whether or not the move
# is valid. Finally, if they have succeeded in moving all of the discs to
# another pile, they win! The loop should end.
#
# You'll want a `TowersOfHanoi#render` method. Don't spend too much time on
# this, just get it playable.
#
# Think about what other helper methods you might want. Here's a list of all the
# instance methods I had in my TowersOfHanoi class:
# * initialize
# * play
# * render
# * won?
# * valid_move?(from_tower, to_tower)
# * move(from_tower, to_tower)
#
# Make sure that the game works in the console. There are also some specs to
# keep you on the right track:
#
# ```bash
# bundle exec rspec spec/towers_of_hanoi_spec.rb
# ```
#
# Make sure to run bundle install first! The specs assume you've implemented the
# methods named above.

class TowersOfHanoi
  DISCS = {
    1 => "    {:}    ",
    2 => "   {:::}   ",
    3 => "  {:::::}  "
  }

  attr_reader :towers

  def self.default
    [[3, 2, 1], [], []]
  end

  def initialize(towers = self.class.default)
    @towers = towers
    @number_of_turns = 0
  end

  def play
    until won?
      render_state

      print "Which pile do you want to select from? "
      from_tower = gets.chomp.to_i

      print "Which pile do you want to move the disc to? "
      to_tower = gets.chomp.to_i

      move(from_tower, to_tower) if valid_move?(from_tower, to_tower)
    end

    conclude
  end

  def conclude
    render_state
    puts "Congratulations! You won. Took you long enough... #{@number_of_turns - 1} turns to be exact."
  end

  # TODO heredoc
  def render_state
    DISCS.default = " " * 11
    puts <<~RENDER

       #{DISCS[towers[0][2]]} #{DISCS[towers[1][2]]} #{DISCS[towers[2][2]]}
       #{DISCS[towers[0][1]]} #{DISCS[towers[1][1]]} #{DISCS[towers[2][1]]}
       #{DISCS[towers[0][0]]} #{DISCS[towers[1][0]]} #{DISCS[towers[2][0]]}
      |=====^=====|=====^=====|=====^=====|
      |  Tower 0  |  Tower 1  |  Tower 2  |
      |===========|===========|===========|

    RENDER
  end

  def move(from_tower, to_tower)
    if valid_move?(from_tower, to_tower)
      towers[to_tower] << towers[from_tower].pop
    end
  end

  def valid_move?(from_tower, to_tower)
    if towers[from_tower].last.nil?
      false
    elsif towers[to_tower].last.nil?
      true
    elsif towers[from_tower].last < towers[to_tower].last
      true
    end
  end

  def won?
    @number_of_turns += 1
    towers[0].empty? && (towers[1].empty? || towers[2].empty?)
  end
end

# ~ notes
# `(towers[1].empty? || towers[2].empty?)`
# can be written as `@towers[1..2].any?(&:empty?)`

if $PROGRAM_NAME == __FILE__
  TowersOfHanoi.new.play
end
