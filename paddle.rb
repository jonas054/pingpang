# frozen_string_literal: true

require './graphic_object'

# Either of the two paddles.
class Paddle < GraphicObject
  WIDTH = BASE_SIZE * 3
  HEIGHT = 5 * WIDTH
  SPEED = 6

  def total_speed = SPEED + @score.total / 10

  def move_towards_ball(ball)
    set_off(0, (ball.y + Ball::HEIGHT / 2 - y - HEIGHT / 2) / 60.0)
  end

  def self.random_y_pos(height)
    Ball::HEIGHT + rand(height - HEIGHT - 2 * Ball::HEIGHT)
  end
end
