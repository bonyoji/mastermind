class Game
  @@winner = false

  def initialize
    puts "\r"
    puts 'Welcome to the game of Mastermind!'
    puts 'The Computer has chosen a secret code'
    puts 'Try to solve it within 12 turns!'
    puts "\r"
    computer_code
    codebreaker
  end

  def computer_code
    @computer_code = Array.new(4) { rand(1..6) }
  end

  def codebreaker
    turn = 1
    until turn > 12 || @@winner do
      p @computer_code
      puts 'Guess four numbers that are between 1 - 6'
      input = gets.chomp
      @guess = input.split('').map{ |v| v.to_i}

      if valid?
        check_guess
        turn += 1
        puts "\r"
      else
        puts "\r"
        puts 'Not a valid entry!'
        codebreaker
      end
    end
    game_over
  end

  def valid?
    if @guess.length == 4 && @guess.all? { |i| i.between?(1, 6) }
      return true
    end
    return false
  end

  def check_guess
    if @guess == @computer_code
        @@winner = true
        game_over
    end
    @hint = []
    @guess.each_with_index do |v, i|
      if v == @computer_code[i]
        @hint[i] = 'G'
      elsif @computer_code.include?(v)
        @hint[i] = 'P' #Not sure how to stop duplicates for same number here
      else
        @hint[i] = nil
      end
    end
  end

  def game_over
    if @@winner
      puts "\r"
      puts 'You Win! Congratulations!'
    else
      puts "\r"
      puts 'You Lose! Better luck next time!'
    end
  end
end

Game.new
