
class Post
  attr_reader :id, :message, :type, :link

  def initialize(id, message, type, link)
    @id = id
    @message = message
    @type = type
    @link = link
  end

  def to_s
    return "|Id: #{@id} message: #{@message} Type: #{@type} Link: #{@link}"
  end
end
