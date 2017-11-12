class Simon
  COLORS = %w(red blue green yellow)

  attr_accessor :sequence_length, :seq, :game_over

  def initialize
    @sequence_length = 1
    @seq = []
    @game_over = false
  end

  def play
    welcome_message

    take_turn until game_over?

    game_over_message
    reset_game
    # play
  end

  def take_turn
    show_sequence
    require_sequence
    round_success_message

    self.sequence_length += 1
  end

  def show_sequence
    add_random_color
    sleep(4)

    seq.each do |color|
      system("clear") || system("cls")
      puts color
      sleep(1)
    end
  end

  def require_sequence
    system("clear") || system("cls")
    puts "What was the sequence?\nType each color's first letter individually:"

    seq.each do |correct_color|
      begin
        color_choice = gets.chomp
        if color_choice.length > 1
          raise
        elsif color_choice != correct_color[0]
          @game_over = true
          break
        end
      rescue
        puts "Try entering a valid color. Pick from #{colors_message}"
        retry
      end
    end
  end

  def add_random_color
    @seq << COLORS.sample
  end

  def game_over?
    @game_over
  end

  def welcome_message
    system("clear") || system("cls")
    puts "Let's play Simon.\nYou'll see some colors in some order.\nRemember the order!"
  end

  def round_success_message
    puts "Round #{sequence_length} is over."
  end

  def game_over_message
    puts "Game over. You lasted #{sequence_length - 1} rounds.\nYou meant to write #{colors_message}."
  end

  def colors_message
    COLORS.map { |clr| clr[0] }.join(", ")
  end

  def reset_game
    @sequence_length = 1
    @seq = []
    @game_over = false
  end
end

Simon.new.play if $PROGRAM_NAME == __FILE__
