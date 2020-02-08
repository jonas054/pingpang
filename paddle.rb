# frozen_string_literal: true

require './graphic_object'
require './ball'

# Either of the two paddles.
class Paddle < GraphicObject
  WIDTH = Ball::WIDTH
  HEIGHT = 5 * Ball::HEIGHT
  SPEED = 6

  def initialize(score)
    super(score)
  end

  def total_speed
    SPEED + @score.total / 10
  end
end
