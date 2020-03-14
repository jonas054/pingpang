require 'test/unit'
require './ball'
require './score'

class TestBall < Test::Unit::TestCase
  def setup
    window = Gosu::Window.new(100, 100)
    @score = Score.new(window,
                       Gosu::Font.new(window, 'Arial', Score::FONT_SIZE))
    @ball = Ball.new(@score)
    assert @ball.not_served_yet?
  end

  def test_moving
    @ball.place(3, 5)
    @ball.set_off(1, 0)
    @ball.move

    assert_equal 9, @ball.total_speed
    assert_equal 12, @ball.x
    assert_equal 5, @ball.y
  end

  def test_bounce_off_top_or_bottom
    @ball.place(3, 5)
    @ball.set_off(1, 2)

    assert_equal 4, @ball.total_speed.round
    assert_equal 3, @ball.x
    assert_equal 5, @ball.y

    @ball.bounce_off_top_or_bottom
    @ball.move

    assert_equal 7, @ball.x.round
    assert_equal -3, @ball.y.round
  end

  def test_bounce_off_paddle
    @ball.place(3, 5)
    @ball.set_off(1, 2)

    assert_equal 4, @ball.total_speed.round
    assert_equal 3, @ball.x
    assert_equal 5, @ball.y

    @ball.bounce_off_paddle(5)
    @ball.move

    assert_equal -2, @ball.x.round
    assert_equal 12, @ball.y.round
  end

  def test_hits_right_paddle
    paddle = Paddle.new(@score)
    @ball.place(3, 5)
    paddle.place(3, 5)
    assert @ball.hits_right_paddle?(paddle)
  end

  def test_hits_left_paddle
    paddle = Paddle.new(@score)
    @ball.place(3, 5)
    paddle.place(3, 5)
    assert @ball.hits_left_paddle?(paddle)
  end

  def test_total_speed
    @ball.set_off(1, 0)
    assert_equal 9, @ball.total_speed
    10.times do
      @score.increment(:left)
      @score.increment(:right)
    end
    assert_equal 13, @ball.total_speed
  end
end
