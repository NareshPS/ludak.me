require_relative 'throw_if'

=begin
  Representation for an album.
=end
module Albatross
  class Album
    attr_reader :title, :image_sets, :caption

    def initialize(title, image_sets, caption = nil)
      ThrowIf.is_nil? title, "title"
      ThrowIf.is_nil? image_sets, "image_sets"
      @title = title
      @image_sets = image_sets
      @caption = caption
    end

    def to_s
      "|Title: #{title} Image Sets: #{image_sets.to_s} Caption: #{caption}|"
    end
  end
end
