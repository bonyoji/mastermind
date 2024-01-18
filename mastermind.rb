class Game
  @@winner = false

  def initialize
    puts "\r"
    puts 'Welcome to the game of Mastermind!'
    puts 'The Computer has chosen a secret code'
    puts 'Try to solve it within 12 turns!'
    puts "\r"
    @challenger = ''
    playstyle
  end

  def playstyle
    puts "\rDo you want to be the Code Maker? Y / N"
    input = ''
    until is_y_or_n(input)
        input = gets.chomp.downcase
        if !(is_y_or_n(input))
          puts 'Please enter Y or N'
        end
    end
    if input == 'y'
      @challenger = 'cpu'
      puts "\r"
      codemaker
    else
      @challenger = 'human'
      puts "\r"
      @computer_code = random_code
      codebreaker
    end
  end

  def is_y_or_n(input)
    ['y', 'n'].include? input
  end

  def codemaker
    puts "Enter four numbers between 1 - 6"
    user_input = gets.chomp
    user_code = user_input.split('').map { |v| v.to_i}
    if valid?(user_code)
      cpu_challenge(user_code)
    else
      puts 'Not a valid code, try again.'
      codemaker
    end
  end

  def cpu_challenge(user_code)
    turn = 1
    cpu_guess = random_code
    until turn > 12 || @@winner
      if cpu_guess == user_code
        @@winner = true
      else
        cpu_guess.each_with_index do |v, i|
          if v == user_code[i]
            cpu_guess[i] = v
          else
            cpu_guess[i] = (v + 1) % 6
            # want to add a method to include
            # numbers that are hinted
          end
        end
      end
      p cpu_guess
      turn += 1
    end
    game_over
  end

  def random_code
    Array.new(4) { rand(1..6) }
  end

  def codebreaker
    turn = 1
    until turn > 12 || @@winner
      puts 'Guess four numbers that are between 1 - 6'
      input = gets.chomp
      user_guess = input.split('').map{ |v| v.to_i}

      if valid?(user_guess)
        puts "\r"
        check_guess(user_guess)
        turn += 1
      else
        puts "\r"
        puts 'Not a valid entry!'
        codebreaker
      end
    end
    game_over
  end

  def valid?(array)
    if array.length == 4 && array.all? { |i| i.between?(1, 6) }
      return true
    end
    return false
  end

  def check_guess(array)
    if array == @computer_code
        @@winner = true
    else
      @hint = []
      array.each_with_index do |v, i|
        if v == @computer_code[i]
          @hint[i] = 'G'
        elsif @computer_code.include?(v)
          @hint[i] = 'P' #Not sure how to stop duplicates for same number here
        else
          @hint[i] = nil
        end
      end
      p @hint
    end
  end

  def game_over
    if @challenger == 'human'
      if @@winner
        puts 'You Win! Congratulations!'
      else
        puts 'You Lose! Better luck next time!'
      end
    else
      if @@winner
        puts 'Computer Wins! You Lose!'
      else
        puts 'You Win! Congratulations!'
      end
    end
  end
end

Game.new
