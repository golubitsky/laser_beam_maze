class LaserBeam
  FORWARD_MIRROR = { E: :N, N: :E, S: :W, W: :S }
  BACKWARD_MIRROR = { W: :N, N: :W, S: :E, E: :S }

  attr_reader :maze, :current_x, :current_y, :square_count, :path

  def initialize(maze)
    @maze = maze
    @current_x = maze.start_x
    @current_y = maze.start_y
    @direction = maze.start_direction
    @square_count = 0
    @last_coordinate
    @path = {}
  end

  def can_travel_to_next_square?
    in_bounds?
  end

  def travel_to_next_square!
    move_one_square

    if in_bounds?
      record_current_position_in_path
      increment_square_counter
      change_direction_if_necessary
    end
  end

  def last_x
    return path.keys.last[0] if path.keys.last
    maze.start_x
  end

  def last_y
    return path.keys.last[1] if path.keys.last
    maze.start_y
  end

  private

  def in_bounds?
    (0...@maze.width) === @current_x && (0...@maze.height) === @current_y
  end

  def record_current_position_in_path
    @path[[@current_x, @current_y]] = true
  end

  def move_one_square
    case @direction
    when :N
      @current_y += 1
    when :E
      @current_x += 1
    when :S
      @current_y -= 1
    when :W
      @current_x -= 1
    end
  end

  def increment_square_counter
    @square_count += 1
  end

  def change_direction_if_necessary
    return if current_square_empty?
    @direction = FORWARD_MIRROR[@direction] if at_forward_mirror?
    @direction = BACKWARD_MIRROR[@direction] if at_backward_mirror?
  end

  def current_square_empty?
    @maze[@current_y][@current_x] == :empty
  end

  def at_forward_mirror?
    @maze[@current_y][@current_x] == "/"
  end

  def at_backward_mirror?
    @maze[@current_y][@current_x] == "\\"
  end
end
