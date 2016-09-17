require_relative 'tic_tac_toe_node'

class SuperComputerPlayer < ComputerPlayer
  def move(game, mark)
    current_state = TicTacToeNode.new(game.board, mark)
    children = current_state.children
    children.each do |child|
      return child.prev_move_pos if child.winning_node?(mark)
    end

    children.each do |child|
      return child.prev_move_pos unless child.losing_node?(mark)
    end

    raise "No non, losing nodes!"
  end
end

if __FILE__ == $PROGRAM_NAME
  # puts "Play the brilliant computer!"
  hp = HumanPlayer.new("Jeff")
  cp = SuperComputerPlayer.new

  TicTacToe.new(hp, cp).run
end
