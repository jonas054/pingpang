require './graphic_object'
require './ball'

# Either of the two paddles.
class Paddle < GraphicObject
  WIDTH = Ball::WIDTH
  HEIGHT = 5 * Ball::HEIGHT
  SPEED = 5

  def initialize(score)
    super(score)
  end

  def total_speed
    SPEED + @score.total / 10
  end
end