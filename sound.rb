# Player for the sounds.
class Sound
  def initialize
    @hit_sample = Gosu::Sample.new('Plopp3.m4a')
    @miss_sample = Gosu::Sample.new('Miss.m4a')
    @bounce_sample = Gosu::Sample.new('nomail.wav')
  end

  def hit
    @hit_sample.play(0.3)
  end

  def miss
    @miss_sample.play(0.3, 2)
  end

  def bounce
    @bounce_sample.play
  end
end
