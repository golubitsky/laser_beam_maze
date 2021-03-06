module LaserMaze
  class Program
    attr_reader :options

    def initialize
      LaserMaze::Logger.init
      @start_time = Time.new
      @options = parse_options
    end

    def run

      if @options[:help]
        print_help
        return
      end

      raise FileNamesMissingError unless ARGV[0] && ARGV[1]

      if options[:generate]
        raise InputDirectoryError unless valid_directory?(ARGV[0])
        LaserMaze::Generator.new.run
      end

      check_source_and_destination

      solver = LaserMaze::Solver.new
      solver.run

      solver.view.render if @options[:render]

      msg = "LaserMaze completed in #{((Time.now - @start_time) * 1000).round(2)} ms"
      LaserMaze::Logger.add(msg)
      LaserMaze::Logger.print if @options[:log]
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
      raise InputDirectoryError unless valid_directory?(ARGV[0])
      raise InputFileMissingError unless File.exists?(ARGV[0])
      raise OutputDirectoryError unless valid_directory?(ARGV[1])
    end

    def valid_directory?(file_str)
      dir = file_str.split('/')
      dir.pop
      File.directory?(dir.join('/'))
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
