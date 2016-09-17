require_relative 'tic_tac_toe'

class TicTacToeNode
  attr_reader :board, :next_mover_mark, :prev_move_pos
  def initialize(board, next_mover_mark, prev_move_pos = nil)
    @board = board
    @next_mover_mark = next_mover_mark
    @prev_move_pos = prev_move_pos
  end

  def losing_node?(evaluator)
    if @board.over?
      return @board.won? && @board.winner != evaluator
    else
      if evaluator == next_mover_mark
        # if our turn, do all moves lead to losers?
        return children.all? { |child| child.losing_node?(evaluator) }
      else
        # if oponent's turn, any chance we'll lose?
        return children.any? { |child| child.losing_node?(evaluator) }
      end
    end
  end

  def winning_node?(evaluator)
    if @board.over?
      return @board.winner == evaluator
    else
      if evaluator == next_mover_mark
        # if our turn, any moves lead to win?
        return children.any? { |child| child.winning_node?(evaluator) }
      else
        # if opponent's turn, will we win no matter what move they make?
        return children.all? { |child| child.winning_node?(evaluator)  }
      end
    end
  end

  # This method generates an array of all moves that can be made after
  # the current move.
  def children
    empty_squares.map { |pos| make_new_node(pos) }
  end

  def empty_squares
    empty_squares = []
    (0..2).each do |row|
      (0..2).each do |col|
        empty_squares << [row, col] if @board[[row,col]].nil?
      end
    end
    empty_squares
  end

  def make_new_node(pos)
    next_board = @board.dup
    next_board[pos] = @next_mover_mark
    TicTacToeNode.new(next_board, toggle_marker, pos)
  end

  def toggle_marker
    @next_mover_mark == :x ? :o : :x
  end

  def show
    @board.rows.map { |row| print "#{row} \n" }
    print "\n"
  end
end
