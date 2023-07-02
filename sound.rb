# frozen_string_literal: true

# Player for the sounds.
class Sound
  def initialize
    @hit_sample = Gosu::Sample.new('Plopp3.ogg')
    @miss_sample = Gosu::Sample.new('Miss.ogg')
    @bounce_sample = Gosu::Sample.new('nomail.wav')
  end

  def hit = @hit_sample.play(0.3)
  def miss = @miss_sample.play(0.3, 2)
  def bounce = @bounce_sample.play
end
