
class Video
  attr_reader :id, :message, :link

  def initialize(id, message, link)
    @id = id
    @message = message
    @link = link
  end

  def to_s
    return "|Id: #{@id} message: #{@message} Link: #{@link}"
  end
end
