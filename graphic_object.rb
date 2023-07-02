# frozen_string_literal: true

# Base class for movable objects.
class GraphicObject
  BASE_SIZE = 5

  def initialize(score) = @score = score

  def display(window, color)
    window.draw_rect(x, y, self.class::WIDTH, self.class::HEIGHT, color)
  end

  def set_off(x_direction, y_direction) = @direction = Complex(x_direction, y_direction)
  def stop = set_off(0, 0)
  def move = @pos += @direction * total_speed
  def x = @pos.real
  def y = @pos.imag
  def place(x_pos, y_pos) = @pos = Complex(x_pos, y_pos)
end
