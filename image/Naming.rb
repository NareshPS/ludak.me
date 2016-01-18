require 'fastimage'

class Naming
  @@ELEMENTS_JOINER = "_"

  def Naming.create image_path
    width, height = FastImage.size image_path
    extension = File.extname image_path
    name  = File.basename image_path, extension

    new_name_elements = Arrays.new
    new_name_elements.push name
    new_name_elements.push width
    new_name_elements.push height
    new_name_elements.push extension

    File.join File.dirname(image_path), new_name_elements.join(@@ELEMENTS_JOINER)
  end
end
