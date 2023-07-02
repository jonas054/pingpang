# frozen_string_literal: true

require 'gosu'
require './ball'
require './help'
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
  def initialize(is_against_bot)
    super(1500, 800, fullscreen: false)
    @is_against_bot = is_against_bot
    @left_to_serve = @is_against_bot || rand > 0.5
    @score = Score.new(self, font(1))
    @ball = Ball.new(@score)
    @left_paddle, @right_paddle = Array.new(2) { Paddle.new(@score) }
    @sound = Sound.new
    @help = Help.new(font(2), @is_against_bot, @left_paddle, @right_paddle)
    start
  end

  private def font(scale) = Gosu::Font.new(self, 'Arial', Score::FONT_SIZE / scale)

  def button_down(key_id)
    unless @is_against_bot
      button_down_for_one_player(key_id, @right_paddle, !@left_to_serve, -1,
                                 [Gosu::KB_DOWN, Gosu::KB_UP, Gosu::KB_LEFT])
    end
    button_down_for_one_player(key_id, @left_paddle, @left_to_serve, 1,
                               [Gosu::KB_S, Gosu::KB_W, Gosu::KB_D])
  end

  private def button_down_for_one_player(key_id, paddle, can_serve, serve_direction, keys)
    down, up, serve = keys
    case key_id
    when down then paddle.set_off(0, 1)
    when up   then paddle.set_off(0, -1)
    when serve then serve_if_appropriate(serve_direction, can_serve)
    end
  end

  def button_up(key_id)
    case key_id
    when Gosu::KB_DOWN, Gosu::KB_UP then @right_paddle.stop
    when Gosu::KB_W,    Gosu::KB_S  then @left_paddle.stop
    end
  end

  def update
    if @is_against_bot
      if !@left_to_serve && @ball.not_served_yet?
        serve_if_appropriate(-1, true)
      else
        @right_paddle.move_towards_ball(@ball)
      end
    end
    return if @ball.not_served_yet?

    [@left_paddle, @right_paddle, @ball].each(&:move)
    handle_ball
  end

  private def serve_if_appropriate(direction, condition)
    return unless @ball.not_served_yet? && condition

    @ball.set_off(direction, 0)
    @sound.hit
  end

  private def handle_ball
    if @ball.passed_paddle?(@left_paddle, @right_paddle)
      @score.increment(@ball.x > width / 2 ? :left : :right)
      @left_to_serve = !@left_to_serve
      @sound.miss
      start
    elsif @ball.check_paddle_hit(@left_paddle, @right_paddle)
      @sound.hit
    elsif @ball.check_top_or_bottom_hit(height)
      @sound.bounce
    end
  end

  private def start
    ball_y = Paddle::HEIGHT + rand(height - 2 * Paddle::HEIGHT)
    next_to_ball_y = ball_y - 2 * Ball::HEIGHT
    random_paddle_y = Paddle.random_y_pos(height)
    if @left_to_serve
      place(3 * Ball::WIDTH, ball_y, next_to_ball_y, random_paddle_y)
    else
      place(width - 4 * Ball::WIDTH, ball_y, random_paddle_y, next_to_ball_y)
    end
    [@ball, @left_paddle, @right_paddle].each(&:stop)
  end

  private def place(ball_x, ball_y, left_paddle_y, right_paddle_y)
    @ball.place(ball_x, ball_y)
    @left_paddle.place(Ball::WIDTH, left_paddle_y)
    @right_paddle.place(width - 2 * Ball::WIDTH, right_paddle_y)
  end

  def draw
    draw_rect(width / 2 - 1, 0, 2, height, Gosu::Color::WHITE) # The net
    @score.display
    @help.display(@left_to_serve) if @ball.not_served_yet? && @score.total < 2
    @ball.display(self, Gosu::Color::GREEN)
    [@left_paddle, @right_paddle].each { _1.display(self, Gosu::Color::WHITE) }
  end
end

PongWindow.new(ARGV.include?('-b')).show
