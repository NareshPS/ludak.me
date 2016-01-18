class ImageCopies
=begin
  Image names are formatted as IMG_<ID>_<SCALING_FACTOR>.jpg
=end
   end
  @@IMG_PREFIX = "IMG"
  @@ELEMENTS_DELIMITER = "_"
  @@SCALING_FACTORS = [100, 80, 60, 50]

  def ImageCopies.scaling_factors
    @@SCALING_FACTORS
  end

  def ImageCopies.id
  end

  def ImageCopies.elements

  end
end
