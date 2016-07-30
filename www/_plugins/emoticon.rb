#Maps emoticons to unicode value.
module Jekyll
  module EmoticonToUnicode
    def emoticon(content)
      return false if !content

      config = @context.registers[:site].config
      config['emoticon_mapping'].each do |smiley|
        content = content.to_str.gsub("#{smiley['name']}", smiley['unicode_name'])
      end
      content
    end
  end
end

Liquid::Template.register_filter(Jekyll::EmoticonToUnicode)
