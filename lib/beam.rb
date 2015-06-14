class LaserBeam
  FORWARD_MIRROR = { E: :N, N: :E, S: :W, W: :S }
  BACKWARD_MIRROR = { W: :N, N: :W, S: :E, E: :S }

  attr_reader :current_x, :current_y, :square_count, :last_x, :last_y

  def initialize(maze)
    @maze = maze
    @current_x = maze.start_x
    @current_y = maze.start_y
    @direction = maze.start_direction
    @square_count = 0
    @last_coordinate
  end

  def can_travel_to_next_square?
    in_bounds?
  end

  def travel_to_next_square!
    remember_last_position
    move_one_square

    if in_bounds?
      increment_square_counter
      change_direction_if_necessary
    end
  end

  private

  def in_bounds?
    (0...@maze.width) === @current_x && (0...@maze.height) === @current_y
  end

  def remember_last_position
    @last_x, @last_y = @current_x, @current_y
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
