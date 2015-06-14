class Generator
  STARTING_POSITIONS = [:N, :E, :S, :W]

  attr_reader :width, :height, :start_pos

  def initialize
    @output_file = "lib/random_maze.txt"
    @width = 10
    @height = 10
    @start_pos = [rand(width), rand(height)]
  end

  def run
    File.open(@output_file, 'w+') do |f|
      # dimensions
      f.puts("#{width} #{height}")
      # starting position
      f.puts("#{start_pos[0]} #{start_pos[1]} #{rand_start_pos}")
      # mirrors
      rand(30).times do
        pos = [rand(width), rand(height)]
        pos = [rand(width), rand(height)] while pos == start_pos

        f.puts("#{pos[0]} #{pos[1]} #{rand_mirror}")
      end
    end
  end

  private

  def rand_mirror
    mirror = rand(2) == 0 ? "\\" : "/"
  end

  def rand_start_pos
    STARTING_POSITIONS[rand(STARTING_POSITIONS.length)]
  end
end
