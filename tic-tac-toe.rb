

module TicTacToe
  
  class Game
    def initialize
      @completed = false
      @user = Human.new('You', 'X')
      @computer = Computer.new('Computer', 'O')
      @results = ""
      @board = Board.new
    end

    def play
      if @completed
        put @results
      else
        puts @board.to_s
        winner = nil

        while !@board.empty_spaces.empty? && winner == nil
          [@user, @computer].each do |player|
            @board.mark(player.getChoice(@board) - 1, player.tile)
            puts "Move made by #{player.name}:"
            puts @board.to_s

            break if (winner = @board.winner) != nil || @board.empty_spaces.empty?
          end
        end

        @completed = true

        if winner == @user.tile
          @results << "Winner: #{@user.name}!"
        elsif winner == @computer.tile
          @results << "Winner: #{@computer.name}!"
        else
          @results << "Cat's game!"
        end

        puts @results
      end
    end
  end

  class Board
    attr_reader :spaces

    @@winning_patterns = [[0, 1, 2], [3, 4, 5], [6, 7, 8], [0, 3, 6], [1, 4, 7], [2, 5, 8], [0, 4, 8], [6, 4, 2]]

    @@empty_board =  "   |   |   \n"
    @@empty_board << "   |   |   \n"
    @@empty_board << "   |   |   \n"
    @@empty_board << "---+---+---\n"
    @@empty_board << "   |   |   \n"
    @@empty_board << "   |   |   \n"
    @@empty_board << "   |   |   \n"
    @@empty_board << "---+---+---\n"
    @@empty_board << "   |   |   \n"
    @@empty_board << "   |   |   \n"
    @@empty_board << "   |   |   "

    def initialize
      @spaces = Array.new(9, " ")
    end

    def mark (space, value)
      @spaces[space] = value.upcase if value.upcase == 'X' || value.upcase == 'O'
    end

    def winner
      retVal = nil

      ['X', 'O'].each do |val|
        @@winning_patterns.each do |space|
          if val == spaces[space[0]] && val == spaces[space[1]] && val == spaces[space[2]]
            retVal = val
          end
        end
      end

      return retVal
    end

    def to_s
      retVal = @@empty_board

      retVal[13] = spaces[0]
      retVal[17] = spaces[1]
      retVal[21] = spaces[2]
      retVal[61] = spaces[3]
      retVal[65] = spaces[4]
      retVal[69] = spaces[5]
      retVal[109] = spaces[6]
      retVal[113] = spaces[7]
      retVal[117] = spaces[8]

      return retVal
    end

    def empty_spaces
      retVal = []
      @spaces.each_index {|index| retVal << index if @spaces[index] == " "}
      return retVal
    end
  end

  class Player
    attr_reader :name, :tile
    def initialize(name, tile)
      @name = name
      @tile = tile
    end
  end

  class Human < Player
    def getChoice(board)
      print "Choose a position (from 1 to 9) to place a piece: "
      choice = gets.chomp.to_i
      until board.empty_spaces.include?(choice - 1)
        puts "Invalid input."
        print "Choose a position (from 1 to 9) to place a piece: "
        choice = gets.chomp.to_i
      end

      return choice
    end
  end

  class Computer < Player
    def getChoice(board)
      return board.empty_spaces.sample + 1
    end
  end

end


include TicTacToe

puts "Welcome to Tic-Tac-Toe"

play_again = true
while play_again
  tttGame = Game.new
  tttGame.play

  # prompt for replay
  puts "Play again? (Y/N)"
  play_again_input = gets.chomp
  play_again = false unless ['Y', 'YES'].include? play_again_input.upcase
end
