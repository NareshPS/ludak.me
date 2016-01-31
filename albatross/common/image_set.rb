require 'set'
require_relative 'throw_if'

=begin
  Multi-size representation of an image.
=end
module Albatross
  class ImageSet
    attr_reader :images, :caption

    def initialize(images, caption = nil)
      ThrowIf.is_nil? images, "images"
      @images = images
      @caption = caption
    end

    def to_s
      "|Caption: #{caption} Count: #{images.size} Images: #{images.to_s}|"
    end
  end
end
