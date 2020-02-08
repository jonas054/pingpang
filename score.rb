# frozen_string_literal: true

# Keeping the scores and displaying them.
class Score
  FONT_SIZE = 40

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
    right = @right_score.to_s
    @font.draw_text(left, middle - 20 - left.length* FONT_SIZE / 2.3, 10,
                    0, 1, 1, Gosu::Color::GREEN)
    @font.draw_text(right, middle + 15, 10, 0, 1, 1, Gosu::Color::GREEN)
  end
end
