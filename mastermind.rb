class Game
  @@turn = 1

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
    puts 'Guess four numbers that are between 1 - 6'
    input = gets.chomp
    @guess = input.split('').map{ |v| v.to_i}

    if valid?
        check_guess
    else
      puts "\r"
      puts 'Not a valid entry!'
      codebreaker
    end
  end

  def valid?
    if @guess.length == 4
      @guess.each do |i|
        if !(i.between?(1, 6))
          return false
        end
      end
      return true
    end
    return false
  end

  def check_guess
    @hint = []
    @guess.each_with_index do |v, i|
      if v.to_i == @computer_code[i]
        @hint << 'G'


      end
    end
  end
end

Game.new
