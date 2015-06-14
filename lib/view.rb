class MazeView
  attr_reader :maze, :beam, :fast_beam

  def initialize(maze, beam, fast_beam)
    @maze = maze
    @beam = beam
    @fast_beam = fast_beam
    @completed_maze = maze
  end

  def render
    maze_view = []
    @maze.each.with_index do |line, y|
      str = ''
      str << padded_y_label(y) # print y-axis label before each line
      line.each_with_index do |char, x|
        str << "|"
        if beam.path[[x,y]]
          str << "*"
        elsif [x,y] == [maze.start_x, maze.start_y]
          str << "#{maze.start_direction}"
        else
          char == :empty ? str << "‾" : str << char.to_s
        end
      end
      str << "|"

      maze_view << str
    end

    puts maze_view.reverse
    print_last_line_of_maze
    print_x_axis_label
  end

  protected

  def print_last_line_of_maze
    puts "Y ".center(5) + ("‾" * @maze.width).split('').join(' ')
  end

  def padded_y_label(n)
    n.to_s.center(4)
  end

  def print_x_axis_label
    digits = [*0..9].cycle
    top_line = ["  X".center(4)]
    bottom_line = ["".center(5)]
    maze.width.times do |n|
      top_line << digits.next
    end
    puts top_line.join(' ')

    tens = (0...(maze.width)).step(10).map { |i| i.to_s + ' ' * 18 }
    puts "tens".center(5) + tens.join
  end
end
