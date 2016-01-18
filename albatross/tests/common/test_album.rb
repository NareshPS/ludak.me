require 'minitest/autorun'
require 'minitest/mock'
require 'set'
require_relative '../../common/album'

module Albatross
  describe Album do
    before do
      TITLE ||= "album title"
      CAPTION ||= "album caption"
      IMAGE_SETS ||= Set.new

      @album ||= Album.new(title: TITLE, image_sets: IMAGE_SETS, caption: CAPTION)
    end

    describe "when initialized with nil parameters" do
      it "must raise ArgumentError" do
        -> {Album.new(title: nil, image_sets: IMAGE_SETS, caption: CAPTION)}.must_raise ArgumentError
        refute_nil Album.new(title: TITLE, image_sets: IMAGE_SETS)
        -> {Album.new(TITLE, CAPTION, image_sets: nil)}.must_raise ArgumentError
      end
    end

    describe :to_s do
      it "must return string representation of album" do
        Set.stub :to_s, "image sets" do
          assert_equal @album.to_s, "|Title: #{TITLE} Image Sets: #{IMAGE_SETS.to_s} Caption: #{CAPTION}|"
        end
      end
    end
  end
end
