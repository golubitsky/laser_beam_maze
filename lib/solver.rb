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
      while beam.can_travel_to_next_square?
        beam.travel_to_next_square!
        break if in_loop?
      end

      output_results
    end

    def in_loop?
      # https://en.wikipedia.org/wiki/Cycle_detection#Tortoise_and_hare
      2.times do
        fast_beam.travel_to_next_square! if fast_beam.can_travel_to_next_square?
      end

      if beam == fast_beam && fast_beam.can_travel_to_next_square?
        return @found_loop = true
      end

      false
    end

    private

    def output_results
      File.open(@output_file, 'w+') do |f|
        if @found_loop
          f.puts '-1'
        else
          f.puts beam.square_count
          f.puts "#{beam.last_x} #{beam.last_y}"
        end
      end
      LaserMaze::Logger.add("Results saved to #{@output_file}.")
    end
  end
end
