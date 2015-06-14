class Maze
  attr_reader :start_x, :start_y, :start_direction, :width, :height

  def initialize
    @input_file = ARGV[0] || 'lib/test.txt'
    build_maze_from_input_file
  end

  def [](value)
    @grid[value]
  end

  def each(&block)
    @grid.each(&block)
  end

  private

  def build_maze_from_input_file
    puts "Building maze from #{@input_file}.."
    File.open(@input_file) do |f|
      f.each_with_index do |line, index|
        x, y = line.scan(/\d+/).map(&:to_i)

        if index == 0
          if x == 0 || y == 0
            raise ZeroDimensionMazeError
          end
          @width = x
          @height = y
          build_grid(x, y)
        else
          direction = line.scan(/[NESW]/).first
          if direction
            @start_y = y
            @start_x = x
            @start_direction = direction.intern
          end

          mirror = line.scan(/[\/\\]/).first
          @grid[y][x] = mirror if mirror
        end
      end
    end
    true
  end

  def build_grid(x, y)
    @grid = Array.new(y) { |i|  Array.new(x) { :empty } }
  end
end
