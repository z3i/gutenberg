require 'mustache'

module Gutenberg
  DIRECTORY = 'book'
  STRUCTURE = "#{DIRECTORY}/structure.md"

  class View < Mustache
    def escapeHTML(str)
      str
    end

    def name
      repo.capitalize
    end

    def rubygem
      repo
    end

    templates = Dir["#{DIRECTORY}/*.md"]
    templates.delete(STRUCTURE)

    templates.each do |template|
      name = File.basename(template, '.md')
      define_method name do
        ::View.render File.read(template).chomp
      end
    end
  end
end
