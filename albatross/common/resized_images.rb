require 'mini_magick'
require 'uri'

module Albatross
  class ResizedImages
    def initialize(minpx = 600)
      @minpx = minpx
    end

    def self.scale_for_factor(image, scale_factor, target)
      width = (image.width * scale_factor).round
      height = (image.height * scale_factor).round
      image.resize("#{width}x#{height}")
      image.format(image.type)
      image.write(target)
      target
    end

    def generate(name, source, destination)
      basename = File.basename(name, '.*')
      extension = File.extname(name)
      image = MiniMagick::Image.open(URI.escape(source))
      scale_factors = compute_scale_factors(image.width > image.height ? image.width : image.height)
      scaled_images = Hash.new

      scale_factors.each do |scale_factor|
        target = File.join(destination, "#{basename}_#{scale_factor}#{extension}")
        ResizedImages.scale_for_factor(image, scale_factor, target)
        scaled_images[scale_factor] = target
      end
      scaled_images
    end

    def compute_scale_factors(current)
        scale_factors = Array.new
        scale_factor = 1.0
        new = current

        while new >= @minpx
          scale_factors.push(scale_factor)
          new = new / 2
          scale_factor = scale_factor / 2
        end
        scale_factors
    end
  end
end
