# frozen_string_literal: true

require './graphic_object'

# Either of the two paddles.
class Paddle < GraphicObject
  WIDTH = BASE_SIZE * 3
  HEIGHT = 5 * WIDTH
  SPEED = 6

  def initialize(score)
    super(score)
  end

  def total_speed
    SPEED + @score.total / 10
  end
end
