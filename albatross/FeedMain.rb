require_relative './Profile'
require_relative './AccessToken'

profile = Profile.new(AccessToken.get)
videos = profile.videos()

puts videos

