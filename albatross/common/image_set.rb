require 'set'
require_relative 'throw_if'

=begin
  Multi-size representation of an image.
=end
module Albatross
  class ImageSet < Array
    attr_reader :caption

    def initialize(caption = nil)
      @caption = caption
    end

    def to_s
      image_s = self.map {|image| image.to_s}.join ","
      "|Caption: #{caption} Count: #{self.size} Images: #{image_s}|"
    end
  end
end
