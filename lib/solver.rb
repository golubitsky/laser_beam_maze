module LaserMaze
  class Solver
    attr_reader :maze, :view, :beam, :fast_beam

    def initialize(input_file = ARGV[0], output_file = ARGV[1])
      @maze = LaserMaze::Parser.build_maze(input_file)
      @beam = LaserMaze::Beam.new(maze)
      @fast_beam = LaserMaze::Beam.new(maze)
      @view = LaserMaze::View.new(maze, beam, fast_beam)
      @found_loop = false
      @output_file = output_file
    end

    def run
      puts "Laser is traversing the maze."
      while beam.can_travel_to_next_square?
        beam.travel_to_next_square!

        # loop detection
        # https://en.wikipedia.org/wiki/Cycle_detection#Tortoise_and_hare

        2.times do
          fast_beam.travel_to_next_square! if fast_beam.can_travel_to_next_square?
        end

        if beam.current_x == fast_beam.current_x &&
            beam.current_y == fast_beam.current_y &&
            fast_beam.can_travel_to_next_square?
          @found_loop = true
          break
        end
      end

      output_results
    end

    private

    def output_results
      puts "Saving results to #{@output_file}"
      File.open(@output_file, 'w+') do |f|
        if @found_loop
          f.puts '-1'
        else
          f.puts beam.square_count
          f.puts "#{beam.last_x} #{beam.last_y}"
        end
      end
    end
  end
end
