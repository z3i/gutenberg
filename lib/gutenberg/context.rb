require 'mustache'

module Gutenberg
  class Context < Mustache
    def self.load(pattern, exclude = [])
      templates = Dir[pattern] - exclude.map { |p| Dir[p].first }
      templates.each do |template|
        name = File.basename template, File.extname(template)
        define_method(name) { render File.read(template).chomp }
      end
    end

    def self.method_missing(method, *args, &block)
      raise ArgumentError if block_given? and not args.empty?
      define_method(method, &block) if block_given?
      args.empty? ? raise(ArgumentError) : define_method(method) { args.first }
    end

    def escapeHTML(str); str  end
    def name; repo.capitalize end
    def rubygem; repo         end
  end
end
