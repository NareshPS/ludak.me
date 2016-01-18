#! /usr/bin/env ruby

require 'koala'
require_relative 'facebook/constants'
#require_relative 'facebook/profile'

=begin
  Entry point
=end

module Albatross
  Koala.config.api_version = "v2.5"
  access_token = "CAACEdEose0cBAIzhQpDPWNQSrc7bznsz3CJEOkCiR9SyFM6GzAIK2evErwWXeAEuKgNgLlGlQJ0WrzKfRZAAdxiXMRqIKpDOlZCVTb5Dp15tYn4sKhbg9dFO8qzYpNZAFhr7DaXx2P3fX3tRNzNDwYnWPdt58ZAnsdKkSEl4GW0PasJmh2m7JEnJwfjJwdhqyfBesJkYbket4AKt4Dco"
  object_id = 10153209001115636
  user = Koala::Facebook::API.new(access_token)
  image = user.get_object("#{object_id}?fields=name,images")
  puts image
  user.put_picture(image['images'][0]['source'], {:message => image['name']}, "ludak.me")
  #user.put_picture()
  #profile = Profile.new user
end
