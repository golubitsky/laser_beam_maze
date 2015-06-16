module LaserMaze
  class Logger
    class << self
      def init
        @messages = []
      end

      def print
        @messages.each do |msg|
          puts msg
        end
      end

      def add(message)
        @messages << message
      end
    end
  end
end
