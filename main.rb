class Player
  attr_accessor :name, :symbol, :move, :score

  @@number = 0
  @@symbols = ['X', 'O']
  
  def initialize
    @name
    @symbol
    @move
    @score = 0
    @@number += 1
  end

  def get_name
    puts "What is the name of player #{@@number}?"
    self.name = gets.strip
  end

  def get_symbol
    if @@symbols.length == 1
      self.symbol = @@symbols[0]
      puts "Your symbol will be '#{self.symbol}'."
    else
      puts "Which symbol you want to use? X/O"
      self.symbol = gets.strip.upcase
      
      until (@symbol == "X" || @symbol == "O") do
        puts "Symbol has to be either 'X' or 'O'"
        self.symbol = gets.strip.upcase
      end

      @@symbols.delete(@symbol)
    end
  end

  def get_position
    puts "#{self.name}, where do you want to put your symbol?"
    self.move = gets.strip.to_i-1
  end
end

def print_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]}\n---+---+---\n #{board[3]} | #{board[4]} | #{board[5]}\n---+---+---\n #{board[6]} | #{board[7]} | #{board[8]} "
end

def play(board, p1, p2)
  again = true
  while again == true
    for i in 1..9 do
      
      if i.odd?
        make_move(board, p1)
      else
        make_move(board, p2)
      end
      
      if evaluate(board)
        if i.odd?
          p1.score += 1
          puts "#{p1.name} wins!"
        else
          p2.score += 1
          puts "#{p2.name} wins!"
        end
        
        break
      end
  
      if i == 9
        puts "It's a draw!"
        break
      end
  
      print_board(board)
    end
  
    show_score(p1, p2)
    
    puts "Do you want to play again? (y/n)"
    again_answer = gets.strip.downcase

    until again_answer == 'n' || again_answer == 'y'
      puts "y/n only"
      again_answer = gets.strip.downcase
    end

    if again_answer == 'n'
      again = false
      puts "Thanks for playing!"
      break
    end

    board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    print_board(board)
    
  end
end

def make_move(board, player)
  position = player.get_position
  
  until board[position] == position + 1
    puts "That block is filled, choose another block!"
    position = player.get_position
  end
  
  board[position] = player.symbol
end

def evaluate(board)
  win = board[0] == board[1] && board[0] == board[2] ||
        board[3] == board[4] && board[3] == board[5] ||
        board[6] == board[7] && board[6] == board[8] ||
        board[0] == board[3] && board[0] == board[6] ||
        board[1] == board[4] && board[1] == board[7] ||
        board[2] == board[5] && board[2] == board[8] ||
        board[0] == board[4] && board[0] == board[8] ||
        board[2] == board[4] && board[2] == board[6]
end

def show_score(p1, p2)
  puts "Game over!\n#{p1.name}: #{p1.score}\n#{p2.name}: #{p2.score}"
end

player1 = Player.new
player1.get_name()
player1.get_symbol

player2 = Player.new
player2.get_name()
player2.get_symbol

board = [1, 2, 3, 4, 5, 6, 7, 8, 9]
print_board(board)
play(board, player1, player2)
