module LaserMaze
  class Program
    attr_reader :options

    def initialize
      @start_time = Time.new
      LaserMaze::Logger.init
      @options = parse_options

    end

    def parse_options
      options = {}
      return options if ARGV[0] =~ /\.\//

      if ARGV[0] == 'help'
        options[:help] = true
        return options
      end

      ARGV[0].chars do |char|
        options[:generate] = true if char == 'g'
        options[:log] = true if char == 'l'
        options[:render] = true if char == 'r'
      end

      ARGV.shift
      options
    end

    def check_source_and_destination
      raise FileNamesMissingError unless ARGV[0] && ARGV[1]
      raise InputFileMissingError unless File.exists?(ARGV[0])
      dir = ARGV[1].split('/')
      dir.pop
      raise OutputDirectoryError unless File.directory?(dir.join('/'))
    end

    def run
      if @options[:help]
        print_help
        return
      end

      LaserMaze::Generator.new.run if options[:generate]

      begin
        check_source_and_destination
      rescue FileLoadError => e
        puts e.message
        return
      end

      begin
        solver = LaserMaze::Solver.new
        solver.run
      rescue ZeroDimensionMazeError => e
        puts e.message
        return
      end

      solver.view.render if @options[:render]

      msg = "LaserMaze completed in #{((Time.now - @start_time) * 1000).round(2)} ms"
      LaserMaze::Logger.add(msg)
      LaserMaze::Logger.print if @options[:log]
    end

    def print_help
      puts "Usage: ./maze [-grl] ./rel/path/to/input/file ./rel/path/to/output/file"
      puts ""
      puts "".ljust(7) + "**maze always overwrites the output file if one exists**"
      puts ""
      puts "".ljust(7) + "Available Options:"
      puts "".ljust(7) + "-g  generates a random maze, saves it to input_path, and solves it"
      puts "".ljust(7) + "-r  renders path of beam through maze"
      puts "".ljust(11) + "(only for mazes up to 30 characters in width"
      puts "".ljust(7) + "-l  prints log"
    end
  end
end
