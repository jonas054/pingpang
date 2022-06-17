# frozen_string_literal: true

require 'test/unit'
require './paddle'
require './score'

class TestPaddle < Test::Unit::TestCase
  def setup
    window = Gosu::Window.new(100, 100)
    @score = Score.new(window,
                       Gosu::Font.new(window, 'Arial', Score::FONT_SIZE))
    @paddle = Paddle.new(@score)
  end

  def test_moving
    @paddle.place(3, 5)
    @paddle.set_off(0, 1)
    @paddle.move

    assert_equal 6, @paddle.total_speed
    assert_equal 3, @paddle.x
    assert_equal 11, @paddle.y
  end

  def test_stop
    @paddle.place(3, 5)
    @paddle.stop
    @paddle.move

    assert_equal 3, @paddle.x
    assert_equal 5, @paddle.y
  end

  def test_total_speed
    assert_equal 6, @paddle.total_speed
    10.times do
      @score.increment(:left)
      @score.increment(:right)
    end
    assert_equal 8, @paddle.total_speed
  end
end
