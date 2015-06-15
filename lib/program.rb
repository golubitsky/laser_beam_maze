require 'byebug'
module LaserMaze
  class Program
    def initialize
      @start_time = Time.new
      parse_options
    end

    def parse_options
      return if ARGV[0] =~ /\.\//
      opts = {}
      ARGV[0].chars{ |char| opts[char] = true }
      ARGV.shift

      @render = true if opts['r']
      LaserMaze::Generator.new.run if opts['g']
    end

    def valid_arguments_provided?
      raise FileNamesMissingError unless ARGV[0] && ARGV[1]
      raise InputFileMissingError unless File.exists?(ARGV[0])
      dir = ARGV[1].split('/')
      dir.pop
      raise OutputDirectoryError unless File.directory?(dir.join('/'))
    end

    def run
      begin
        valid_arguments_provided?
      rescue FileLoadError => e
        puts e.message
        return
      end

      begin
        solver = LaserMaze::Solver.new
        solver.run
        solver.view.render if @render
      rescue ZeroDimensionMazeError => e
        puts e.message
        return
      end
      puts "LaserMaze completed in #{((Time.now - @start_time) * 1000).round(2)} ms"
    end
  end
end
