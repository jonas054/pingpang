# Base class for movable objects.
class GraphicObject
  def initialize(score)
    @score = score
  end

  def display(window, color)
    window.draw_rect(x, y, self.class::WIDTH, self.class::HEIGHT, color)
  end

  def set_off(x_direction, y_direction)
    @direction = Complex(x_direction, y_direction)
  end

  def stop
    set_off(0, 0)
  end

  def move
    @pos += @direction * total_speed
  end

  def x
    @pos.real
  end

  def y
    @pos.imag
  end

  def place(x_pos, y_pos)
    @pos = Complex(x_pos, y_pos)
  end
end
