
class Image
  attr_reader :source, :width, :height

  def initialize(source, width, height)
    @source = source
    @width = width
    @height = height
  end

  def to_s()
    return "|Source: #{@source} Width: #{@width} Height: #{@height}|"
  end
end
