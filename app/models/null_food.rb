class NullFood
  attr_reader :color, :color_count
  def initialize(color)
    @color = color
    @color_count = 0
  end
end