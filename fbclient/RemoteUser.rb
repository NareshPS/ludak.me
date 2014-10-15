
class RemoteUser
  attr_reader :basic_info
  @@Me = "me"
  @@Id = "id"
  @@Albums = "albums"
  @@Data = "data"
  @@AlbumsUri = "/me?fields=albums{name,description}"

  def initialize(access_token)
    @access_token = access_token
    @user ||= Koala::Facebook::API.new(access_token)
    unravel()
  end

  def unravel()
    @basic_info ||= @user.get_object(@@Me)
    @id ||= @basic_info ['id']
  end

  def albums(album_list = [])
    @albums ||= @user.get_object(@@AlbumsUri)
    puts @albums
  end

  def to_s()
    return "Id: #{@id}"
  end

  private :unravel
end
