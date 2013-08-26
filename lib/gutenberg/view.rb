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

    def self.load(pattern)
      templates = Dir[pattern]
      templates.delete(STRUCTURE)
      templates.each do |template|
        name = File.basename(template, File.extname(template))
        define_method name do
          ::View.render File.read(template).chomp
        end
      end
    end

    load "#{DIRECTORY}/*.md"
  end
end
