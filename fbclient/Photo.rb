
class Photo < Array
  attr_reader :id, :caption

  def initialize(id, caption)
    @id = id
    @caption = caption
    super()
  end

  def images()
    Array.new(self)
  end

  def to_s()
    return "|Id: #{@id} Caption: #{@caption} # of Copies: #{self.length}|"
  end
end
