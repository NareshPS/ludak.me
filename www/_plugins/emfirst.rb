#Emphasize first character.
module Jekyll
  module EmphasizeFirst
    def emfirst(content)
      return false if !content

      return "<strong><span style=\"font-size:2em\">#{content[0]}</span></strong>#{content[1..-1]}"
    end
  end
end

Liquid::Template.register_filter(Jekyll::EmphasizeFirst)
