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
  def check_paddle_hit(paddles)
    if hits_left_paddle?(paddles[0])
      bounce_off_paddle(paddles[0].y)
      true
    elsif hits_right_paddle?(paddles[1])
      bounce_off_paddle(paddles[1].y)
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

  def passed_paddle?(paddles)
    @direction.real > 0 ? x > paddles[1].x + WIDTH : x < paddles[0].x - WIDTH
  end
end
