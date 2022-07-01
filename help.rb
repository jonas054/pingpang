# frozen_string_literal: true

require 'gosu'

# Showing which keys to use.
class Help
  def initialize(font, is_against_bot, left_paddle, right_paddle)
    @font = font
    @is_against_bot = is_against_bot
    @left_paddle = left_paddle
    @right_paddle = right_paddle
  end

  def display(left_to_serve)
    serve_keys = left_to_serve ? ['D', ''] : ['', '⬅️']
    draw_letters(@left_paddle, 'W', 'S', serve_keys.first, 4)
    return if @is_against_bot

    draw_letters(@right_paddle, '⬆️', '⬇️', serve_keys.last, -4)
  end

  def draw_letters(paddle, up_key, down_key, serve_key, serve_key_offset)
    x = paddle.x
    y = paddle.y
    draw_text(up_key, x, y - @font.height, Gosu::Color::WHITE)
    draw_text(down_key, x, y + Paddle::HEIGHT, Gosu::Color::WHITE)
    draw_text(serve_key, x + Paddle::WIDTH * serve_key_offset,
              y + (Paddle::HEIGHT - @font.height) / 2, Gosu::Color::GREEN)
  end

  private def draw_text(text, x_pos, y_pos, color)
    @font.draw_text(text, x_pos, y_pos, 0, 1, 1, color)
  end
end
