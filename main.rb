# frozen_string_literal: true

require 'gosu'
require './ball'
require './paddle'
require './score'
require './sound'

# The classic Pong game for two players.
#
# The left player uses W for up, S for down, and D to serve.
#
# The right player uses UpArrow for up, DownArrow for down, and
# LeftArrow to serve.
class PongWindow < Gosu::Window
  def initialize
    super(1500, 800, fullscreen: false)
    @left_to_serve = rand > 0.5
    @score = Score.new(self, Gosu::Font.new(self, 'Arial', Score::FONT_SIZE))
    @ball = Ball.new(@score)
    @left_paddle = Paddle.new(@score)
    @right_paddle = Paddle.new(@score)
    @sound = Sound.new
    start
  end

  def button_down(id)
    case id
    when Gosu::KB_DOWN then @right_paddle.set_off(0, 1)
    when Gosu::KB_UP   then @right_paddle.set_off(0, -1)
    when Gosu::KB_LEFT then serve_if_appropriate(-1, !@left_to_serve)
    when Gosu::KB_S    then @left_paddle.set_off(0, 1)
    when Gosu::KB_W    then @left_paddle.set_off(0, -1)
    when Gosu::KB_D    then serve_if_appropriate(1, @left_to_serve)
    end
  end

  def button_up(id)
    case id
    when Gosu::KB_DOWN, Gosu::KB_UP then @right_paddle.stop
    when Gosu::KB_W,    Gosu::KB_S  then @left_paddle.stop
    end
  end

  def update
    return if @ball.not_served_yet?

    [@left_paddle, @right_paddle].each(&:move)
    handle_ball
  end

  def draw
    draw_rect(width / 2 - 1, 0, 2, height, Gosu::Color::WHITE) # The net
    @score.display
    @ball.display(self, Gosu::Color::GREEN)
    @left_paddle.display(self, Gosu::Color::WHITE)
    @right_paddle.display(self, Gosu::Color::WHITE)
  end

  private

  def serve_if_appropriate(direction, condition)
    return unless @ball.not_served_yet? && condition

    @ball.set_off(direction, 0)
    @sound.hit
  end

  def handle_ball
    @ball.move
    if @ball.y <= 0 || @ball.y >= height - Ball::HEIGHT
      @ball.bounce_off_top_or_bottom
      @sound.bounce
    end
    if passed_right_paddle? || passed_left_paddle?
      handle_win
    elsif @ball.hits_right_paddle?(@right_paddle) ||
          @ball.hits_left_paddle?(@left_paddle)
      handle_paddle_hit
    end
  end

  def handle_win
    @score.increment(passed_right_paddle? ? :left : :right)
    @left_to_serve = !@left_to_serve
    @sound.miss
    start
  end

  def handle_paddle_hit
    paddle_pos =
      @ball.hits_right_paddle?(@right_paddle) ? @right_paddle.y : @left_paddle.y
    @ball.bounce_off_paddle(paddle_pos)
    @sound.hit
  end

  def passed_right_paddle?
    @ball.x > @right_paddle.x + Ball::WIDTH
  end

  def passed_left_paddle?
    @ball.x < @left_paddle.x - Ball::WIDTH
  end

  def start
    ball_y = rand(height - Ball::HEIGHT)
    random_paddle_y = rand(height - Ball::HEIGHT)
    next_to_ball_y = ball_y - 2 * Ball::HEIGHT
    right_paddle_x = width - 2 * Ball::WIDTH
    if @left_to_serve
      @ball.place(3 * Ball::WIDTH, ball_y)
      @left_paddle.place(Ball::WIDTH, next_to_ball_y)
      @right_paddle.place(right_paddle_x, random_paddle_y)
    else
      @ball.place(width - 4 * Ball::WIDTH, ball_y)
      @left_paddle.place(Ball::WIDTH, random_paddle_y)
      @right_paddle.place(right_paddle_x, next_to_ball_y)
    end
    [@ball, @left_paddle, @right_paddle].each(&:stop)
  end
end

PongWindow.new.show
