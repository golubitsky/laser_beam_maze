module LaserMaze
  class Maze
    attr_reader :start_x, :start_y, :start_direction

    def initialize(width, height)
      @grid = build_grid(width, height)
    end

    def width
      @grid[0].size
    end

    def height
      @grid.size
    end

    def [](value)
      @grid[value]
    end

    def pos(x, y)
      @grid[y][x]
    end

    def each(&block)
      @grid.each(&block)
    end

    private

    def build_grid(x, y)
      Array.new(y) { |i|  Array.new(x) { :empty } }
    end
  end
end
