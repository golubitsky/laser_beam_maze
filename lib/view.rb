class MazeView
  def initialize(maze, beam, fast_beam)
    @maze = maze
    @beam = beam
    @fast_beam = fast_beam
    @completed_maze = maze
  end

  def inspect
    ## TO DO: rethink view logic to be able to print starting character
    ## without having to store it in the actual maze-grid
    offset = " " * 3

    y = @maze.height - 1
    @maze.each do |line|
      print "#{y} " # print y-axis label before each line
      y -= 1
      str = line.map do |char|
        char == :empty ? "|‾" : "|" + char.to_s
      end.join('') + "|"

      puts str
    end
    # print bottom line
    puts offset + ("‾" * @maze.width).split('').join(' ')
    # print x-axis labels
    offset + (0...@maze.width).map(&:to_s).join(' ')
  end

end
