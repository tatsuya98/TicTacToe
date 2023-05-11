# frozen_string_literal: true

# Player class creates the player
class Player
  attr_reader :symbol, :name

  attr_accessor :wins, :losses

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
    @wins = 0
    @losses = 0
  end

  def player_choice
    puts "#{name} select a number between 0 and 8"
    gets.chomp.to_i
  end
end

# frozen_string_literal: true

# Game class creates board and handles player input and  logic
class Game
  attr_accessor :board, :count

  attr_reader :player1, :player2

  def initialize
    @board = [0, 1, 2, 3, 4, 5, 6, 7, 8]
    @count = 0
    @player1 = Player.new('player1', 'X')
    @player2 = Player.new('player2', 'O')
    @finish = false
  end

  def fill_position(player)
    board[player.player_choice] = player.symbol
  end

  def display_current_grid
    puts "#{board[0]} #{board[1]} #{board[2]}"
    puts "#{board[3]} #{board[4]} #{board[5]}"
    puts "#{board[6]} #{board[7]} #{board[8]}"
  end

  def win_condition
    case
      # horizontal
    when board[0] == board[1] && board[0] == board[2]
      @finish = true
      board[0]
    when board[3] == board[4] && board[3] == board[5]
      @finish = true
      board[3]
    when board[6] == board[7] && board[6] == board[8]
      @finish = true
      board[6]
      # vertical
    when board[0] == board[3] && board[0] == board[6]
      @finish = true
      board[0]
    when board[1] == board[4] && board[1] == board[7]
      @finish = true
      board[1]
    when board[2] == board[5] && board[2] == board[8]
      @finish = true
      board[2]
      # diagonal
    when board[0] == board[4] && board[0] == board[8]
      @finish = true
      board[0]
    when board[2] == board[4] && board[2] == board[6]
      @finish = true
      board[2]
    end
  end

  def announce_result(symbol)
    case symbol
    when 'X'
      display_current_grid
      puts 'Player 1 wins!'
    when 'O'
      display_current_grid
      puts 'Player 2 wins!'
    when 'Tie'
      display_current_grid
      @finish = true
      puts symbol
    end
  end

  def check_result
    if count == @board.length
      announce_result('Tie')
    else
      announce_result(win_condition)
    end
  end

  def game_loop
    board.cycle(board.length) do
      fill_position(player1)
      @count +=1
      check_result
      break if @finish == true
      puts ''
      #display_current_grid
      fill_position(player2)
      puts ''
      display_current_grid
      @count += 1
      puts @count
      check_result
      break if @finish == true
    end
  end
end

tic_tac_toe = Game.new
tic_tac_toe.game_loop
