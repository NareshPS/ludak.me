require_relative 'throw_if'

=begin
  Representation for an album.
=end
module Albatross
  class Album < Array
    attr_reader :title
    attr_accessor :caption, :id

    def initialize(title, caption = nil, id = nil)
      ThrowIf.is_nil? title, "title"
      @title = title
      @caption = caption
      @id = id
    end

    def to_s
      image_set_s = self.map {|image_set| image_set.to_s}.join ","
      "|Id: #{id} Title: #{title} Image Sets: #{image_set_s} Caption: #{caption}|"
    end
  end
end
