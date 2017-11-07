# I/O Exercises
#
# * Write a `guessing_game` method. The computer should choose a number between
#   1 and 100. Prompt the user to `guess a number`. Each time through a play loop,
#   get a guess from the user. Print the number guessed and whether it was `too
#   high` or `too low`. Track the number of guesses the player takes. When the
#   player guesses the number, print out what the number was and how many guesses
#   the player needed.
# * Write a program that prompts the user for a file name, reads that file,
#   shuffles the lines, and saves it to the file "{input_name}-shuffled.txt". You
#   could create a random number using the Random class, or you could use the
#   `shuffle` method in array.

def guessing_game
  target = rand(1..100)

  puts "I picked a number between 1 and 100. Guess a number: "
  guess = nil
  guesses = 0

  until guess == target
    guess = gets.chomp.to_i
    print "You tried #{guess}. Hmm.."

    if guess < target
      print "too low."
    else
      print "too high."
    end

    guesses += 1
  end

  puts "You got it! Took you #{guesses} tries."
end

def shuffle_lines(input_file_path)
  output_file_path = File.basename(input_file_path, File.extname(input_file_path))
  output_file = File.new("#{output_file_path}-shuffled#{File.extname(input_file_path)}", "w")

  shuffled_lines = File.readlines(input_file_path).shuffle
  File.write(output_file, shuffled_lines.join)
  output_file.close
end

if $PROGRAM_NAME == __FILE__
  shuffle_lines("sample.txt")
end
