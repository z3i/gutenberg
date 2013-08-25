$:.unshift File.dirname(__FILE__)
require 'gutenberg/version'
require 'gutenberg/view'

module Gutenberg
  def self.run(file = $stdout)
    require "./#{DIRECTORY}/view"
    file.puts ::View.render File.read(STRUCTURE)
  end
end
