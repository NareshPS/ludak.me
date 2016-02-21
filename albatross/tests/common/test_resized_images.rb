require_relative '../../common/resized_images'

module Albatross
  describe ResizedImages do
    before do
      NAME ||= 'IMG_1177.jpg'
      SOURCE ||= 'https://dl.dropboxusercontent.com/s/ccfuyyhn7m6888f/IMG_1177.jpg?dl=0'
      DESTINATION ||= '/tmp'
    end

    describe :compute_scale_factors do
      it "must generate scale factors" do
        resized_images = ResizedImages.new
        image = MiniMagick::Image.open(SOURCE)
        scale_factors = resized_images.compute_scale_factors(image.width > image.height ? image.width : image.height)
        expect(scale_factors).to eq([0.5, 0.25])
      end
    end

    describe :generate do
      it "must generate resized images" do
        resized_images = ResizedImages.new
        generated_images = resized_images.generate(NAME, SOURCE, DESTINATION)
        expect(generated_images).to eq(["#{DESTINATION}/IMG_1177_0.5.jpg", "#{DESTINATION}/IMG_1177_0.25.jpg"])
        generated_images.each {|f| File.delete(f)}
      end
    end
  end
end
