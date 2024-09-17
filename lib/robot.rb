class Robot
  DIRECTIONS = %w[NORTH EAST SOUTH WEST].freeze

  def initialize
    @x = nil
    @y = nil
    @direction = nil
  end

  def place(x, y, direction)
    if valid_position?(x, y) && DIRECTIONS.include?(direction)
      @x = x
      @y = y
      @direction = direction
    end
  end

  def move
    return unless placed?

    new_x_pos, new_y_pos = case @direction
                           when 'NORTH' then [@x, @y + 1]
                           when 'SOUTH' then [@x, @y - 1]
                           when 'EAST' then [@x + 1, @y]
                           when 'WEST' then [@x - 1, @y]
                           else
                             [nil, nil]
                           end
    @x, @y = new_x_pos, new_y_pos if valid_position?(new_x_pos, new_y_pos)
  end

  def left
    return unless placed?

    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) - 1) % 4]
  end

  def right
    return unless placed?

    @direction = DIRECTIONS[(DIRECTIONS.index(@direction) + 1) % 4]
  end

  def report
    placed? ? "#{@x},#{@y},#{@direction}" : "Robot not placed yet"
  end

  private

  def valid_position?(x, y)
    x.between?(0,4) && y.between?(0,4)
  end

  def placed?
    !@x.nil? && !@y.nil? && !@direction.nil?
  end
end