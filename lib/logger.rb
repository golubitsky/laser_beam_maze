module LaserMaze
  class Logger
    class << self
      def init
        @messages = ["LaserMaze initialized."]
      end

      def print
        @messages.each do |msg|
          puts msg
        end
        puts ""
      end

      def add(message)
        @messages << message
      end
    end
  end
end
