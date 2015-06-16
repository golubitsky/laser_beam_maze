module LaserMaze
  class Generator
    STARTING_POSITIONS = [:N, :E, :S, :W].freeze

    attr_reader :width, :height, :start_pos

    def initialize(max_width = 30, max_height = 30)
      @output_file = ARGV[0]
      @width = rand(max_width) + 1
      @height = rand(max_height) + 1
      @start_pos = [rand(width), rand(height)]

      msg = "Generating #{width}x#{height} random maze and exporting it to #{@output_file}."
      LaserMaze::Logger.add(msg)
    end

    def run
      File.open(@output_file, 'w+') do |f|
        # dimensions
        f.puts("#{width} #{height}")
        # starting position
        f.puts("#{start_pos[0]} #{start_pos[1]} #{rand_start_pos}")
        # mirrors
        rand((@width * @height)/3).times do
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
end
