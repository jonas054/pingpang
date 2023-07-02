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

  def check_top_or_bottom_hit(max_y)
    if y <= 0 || y >= max_y - HEIGHT
      bounce_off_top_or_bottom
      true
    else
      false
    end
  end

  def bounce_off_top_or_bottom = set_off(@direction.real, -@direction.imag)

  # If a hit is detected, bounces the ball off the paddle and returns true.
  def check_paddle_hit(left_paddle, right_paddle)
    if hits_left_paddle?(left_paddle)
      bounce_off_paddle(left_paddle.y)
      true
    elsif hits_right_paddle?(right_paddle)
      bounce_off_paddle(right_paddle.y)
      true
    else
      false
    end
  end

  def bounce_off_paddle(paddle_y_pos)
    dir = (y - paddle_y_pos - Paddle::HEIGHT / 2).to_f / Paddle::HEIGHT
    set_off(-@direction.real, @direction.imag + dir)
  end

  def not_served_yet? = @direction == 0 + 0i

  def hits_right_paddle?(paddle)
    @direction.real > 0 && x >= paddle.x - WIDTH && right_height?(paddle.y)
  end

  def hits_left_paddle?(paddle)
    @direction.real < 0 && x <= paddle.x + Paddle::WIDTH && right_height?(paddle.y)
  end

  private def right_height?(paddle_y)
    y >= paddle_y - HEIGHT && y <= paddle_y + Paddle::HEIGHT
  end

  def total_speed = (SPEED + @score.total / 5) / @direction.abs

  def passed_paddle?(left_paddle, right_paddle)
    @direction.real > 0 ? x > right_paddle.x + WIDTH : x < left_paddle.x - WIDTH
  end
end
