require 'test/unit'
require './score'

class MyFont
  attr_reader :args

  def draw_text(text, x_pos, y_pos, a, b, c, color)
    @args ||= []
    @args << [text, x_pos, y_pos, a, b, c, color]
  end
end

class TestScore < Test::Unit::TestCase
  def setup
    window = Gosu::Window.new(100, 100)
    @font_mock = MyFont.new
    @score = Score.new(window, @font_mock)
  end

  def test_increment
    @score.increment(:left)
    assert_equal 1, @score.total
    @score.increment(:right)
    assert_equal 2, @score.total
  end

  def test_display
    @score.display
    assert_equal 2, @font_mock.args.size
    assert_equal "0", @font_mock.args[0][0]
    assert_equal 0, @font_mock.args[1][0]

    @score.increment(:left)

    @score.display
    assert_equal 4, @font_mock.args.size
    assert_equal "1", @font_mock.args[2][0]
    assert_equal 0, @font_mock.args[3][0]
  end
end
