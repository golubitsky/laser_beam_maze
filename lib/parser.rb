module LaserMaze
  class Parser
    class << self
      attr_accessor :maze, :x, :y, :direction, :mirror

      def build_maze(input_file = ARGV[0])
        File.open(input_file) do |f|
          f.each_with_index do |line, index|
            @x, @y = line.scan(/\d+/).map(&:to_i)
            if index == 0
              parse_first_line
            else
              @direction = line.scan(/[NESW]/).first
              @mirror = line.scan(/[\/\\]/).first
              parse_line
            end
          end
        end
        puts "Processed maze from #{input_file}"
        maze
      end

      def parse_first_line
        raise ZeroDimensionMazeError if x == 0 || y == 0
        @maze = LaserMaze::Maze.new(x, y)
      end

      def parse_line
        if @direction
          @maze.instance_variable_set(:@start_x, x)
          @maze.instance_variable_set(:@start_y, y)
          @maze.instance_variable_set(:@start_direction, @direction.intern)
        end

        @maze[y][x] = @mirror if @mirror
      end
    end
  end
end
