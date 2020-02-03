# Keeping the scores and displaying them.
class Score
  def initialize(window)
    @left_score = @right_score = 0
    @font = Gosu::Font.new(window, 'Arial', 40)
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
    @font.draw_text(@left_score.to_s, 10, 10, 0, 1, 1, Gosu::Color::GREEN)
    @font.draw_text(@right_score.to_s,
                    @window.width - 20 - 14 * @right_score.to_s.length, 10, 0,
                    1, 1, Gosu::Color::GREEN)
  end
end
