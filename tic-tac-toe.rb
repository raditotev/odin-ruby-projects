class Game
  attr_accessor :board

  class Board

    def initialize
      @board = {}
      (1..9).each do |n|
        @board[n] = n
      end
    @board
    end

    def update(pos, player)
      player == 1 ? @board[pos] = "X" : @board[pos] = "O"
    end

    def print
      puts """
      #{@board[1]} | #{@board[2]} | #{@board[3]}
      ----------
      #{@board[4]} | #{@board[5]} | #{@board[6]}
      ----------
      #{@board[7]} | #{@board[8]} | #{@board[9]}
      """
    end

    def check_for_winner
      winner = false

      [0, 3, 6].each do |n|
        ["X", "O"].each do |pull|
          if @board[n + 1] == pull && @board[n + 2] == pull && @board[n + 3] == pull
            winner =  true
         end
        end
      end

      [1, 2, 3].each do |n|
        ["X", "O"].each do |pull|
          if @board[n] == pull && @board[n + 3] == pull && @board[n + 6] == pull
            winner =  true
          end
        end
      end

      ["X", "O"].each do |pull|
         if @board[1] == pull && @board[5] == pull && @board[9] == pull
          winner = true
         end
      end

      ["X", "O"].each do |pull|
         if @board[3] == pull && @board[5] == pull && @board[7] == pull
          winner = true
         end
      end
      winner
    end

    def valid_move position
      @board[position].kind_of? Fixnum
    end
  end # end Board class

  def initialize
    puts """
***********************************************************

    Please choose field by entering the relevant number.

***********************************************************
    """
    @board = Board.new
    self.move
  end

  def move
    notice = ""
    count = 0
    while  count < 9
      if game_won?
        @board.print
        count % 2 == 0 ? (puts "************ Player 2 won this game ************") :
                                     (puts "************ Player 1 won this game ************")
        break
      end
      @board.print
      count % 2 == 0 ? (print "#{notice}Player 1: ") : (print "#{notice}Player 2: ")
      move = gets.chomp.to_i
      if @board.valid_move(move)
        notice = ""
        count % 2 == 0 ? @board.update(move, 1) : @board.update(move, 2)
      else
        puts
        puts "Please choose valid field!" unless @board.valid_move move
        notice = "Please choose valid field this time! "
        count -= 1
      end
      if count == 8
        @board.print
        puts "************  Draw! ************"
      end
      count += 1
    end
  end

  def game_won?
    @board.check_for_winner
  end
end #end Game class

Game.new

