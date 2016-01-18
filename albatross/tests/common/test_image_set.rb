require 'minitest/autorun'
require_relative '../../common/image'
require_relative '../../common/image_set'

module Albatross
  class TestImageSet < Minitest::Spec
    NUM_IMAGES = 3
    IMAGES = Set.new
    CAPTION = "test caption"

    def setup
      IMAGES.clear
      (0...NUM_IMAGES).each {|i| IMAGES << (Image.new "test_image#{i}", i*10, i*5, 'jpg')}
    end

    def test_initialize_valid_params
      image_set = ImageSet.new IMAGES, CAPTION
      images = image_set.images
      assert_equal NUM_IMAGES, images.size
      assert_equal CAPTION, image_set.caption
      (0...NUM_IMAGES).each {|i| assert_equal IMAGES.take(i), images.take(i)}
    end

    def test_initialize_nil_params
      -> {ImageSet.new nil}.must_raise ArgumentError
      refute_nil ImageSet.new IMAGES
    end

    def test_to_s
      image_set = ImageSet.new(IMAGES, CAPTION)
      assert_equal "|Caption: #{CAPTION} Count: #{IMAGES.size} Images: #{IMAGES.to_s}|", image_set.to_s
    end
  end
end
