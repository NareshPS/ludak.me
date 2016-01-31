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

      @album ||= Album.new(TITLE, IMAGE_SETS, CAPTION)
    end

    describe "when initialized with nil parameters" do
      it "must raise ArgumentError" do
        -> {Album.new(nil, IMAGE_SETS, CAPTION)}.must_raise ArgumentError
        refute_nil Album.new(TITLE, IMAGE_SETS)
        -> {Album.new(TITLE, nil, CAPTION)}.must_raise ArgumentError
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
