=begin
  Defines constants used by Facebook Graph API.
=end
module Albatross
  module Facebook
    class Constants
      ALBUMS = "albums"
      CAPTION = "caption"
      DATA = "data"
      DESCRIPTION = "description"
      HEIGHT = "height"
      ID = "id"
      IMAGES = "images"
      LINK = "link"
      ME = "me"
      ME_FIELDS_ALBUMS = "/me?fields=albums{name,description}"
      ME_FIELDS_POSTS = "/me?fields=posts{id,message,type,link}"
      MESSAGE = "message"
      NAME = "name"
      PHOTOS = "photos"
      POSTS = "posts"
      SOURCE = "source"
      TYPE = "type"
      VIDEO = "video"
      WIDTH = "width"
    end
  end
end
