require 'RMagick'

class Resizer
  attr_reader :scaling_factor

  def initialize scaling_factor=1.0
    @scaling_factor = scaling_factor

    raise ArgumentError.new "Invalid scaling_factor: #{scaling_factor}." if scaling_factor > 1.0
  end

  def resize image_file
    image = Magick::Image.read(image_file).first
    scaled_image = image.scale(scaling_factor)
    #    new_image.write("resized/#{image.filename}")

  end
end
