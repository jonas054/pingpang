# frozen_string_literal: true

require './graphic_object'

# The ball in play.
class Ball < GraphicObject
  WIDTH = 10
  HEIGHT = 10
  SPEED = 6

  def initialize(score)
    super(score)
    stop
  end

  def bounce_off_top_or_bottom
    set_off(@direction.real, -@direction.imag)
  end

  def bounce_off_paddle(paddle_y_pos)
    dir = (y - paddle_y_pos - Paddle::HEIGHT / 2).to_f / Paddle::HEIGHT
    set_off(-@direction.real, @direction.imag + dir)
  end

  def not_served_yet?
    @direction == 0 + 0i
  end

  def hits_right_paddle?(paddle)
    @direction.real >= 0 &&
      x >= paddle.x - Ball::WIDTH &&
      y >= paddle.y - Ball::HEIGHT &&
      y <= paddle.y + Paddle::HEIGHT
  end

  def hits_left_paddle?(paddle)
    @direction.real <= 0 &&
      x <= paddle.x + Ball::WIDTH &&
      y >= paddle.y - Ball::HEIGHT &&
      y <= paddle.y + Paddle::HEIGHT
  end

  def total_speed
    (SPEED + @score.total / 5) / @direction.abs
  end
end
