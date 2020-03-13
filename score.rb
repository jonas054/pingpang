# frozen_string_literal: true

require 'gosu'

# Keeping the scores and displaying them.
class Score
  FONT_SIZE = 60
  FONT_WIDTH = FONT_SIZE / 2.3

  def initialize(window)
    @left_score = @right_score = 0
    @font = Gosu::Font.new(window, 'Arial', FONT_SIZE)
    @window = window
  end

  def increment(side)
    if side == :left
      @left_score += 1
    else
      @right_score += 1
    end
  end

  def total
    @left_score + @right_score
  end

  def display
    middle = @window.width / 2
    left = @left_score.to_s
    draw_text(left, middle - (1 + left.length) * FONT_WIDTH, 10)
    draw_text(@right_score, middle + FONT_WIDTH, 10)
  end

  private

  def draw_text(text, x_pos, y_pos)
    @font.draw_text(text, x_pos, y_pos, 0, 1, 1, Gosu::Color::GREEN)
  end
end
