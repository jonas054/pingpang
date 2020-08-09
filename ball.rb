# frozen_string_literal: true

require './graphic_object'
require './paddle'

# The ball in play.
class Ball < GraphicObject
  WIDTH = BASE_SIZE * 3
  HEIGHT = WIDTH
  SPEED = 9

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
    @direction.real > 0 && x >= paddle.x - Ball::WIDTH &&
      right_height?(y, paddle)
  end

  def hits_left_paddle?(paddle)
    @direction.real < 0 && x <= paddle.x + Paddle::WIDTH &&
      right_height?(y, paddle)
  end

  def total_speed
    (SPEED + @score.total / 5) / @direction.abs
  end

  private

  def right_height?(y, paddle)
    y >= paddle.y - Ball::HEIGHT && y <= paddle.y + Paddle::HEIGHT
  end
end
