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
      raise ArgumentError, "#{method} passes both block and #{args.inspect}" if block_given? and not args.empty?
      return define_method(method, &block) if block_given?
      args.empty? ? raise(ArgumentError, "#{method} doesn’t have a value") : define_method(method) { args.first }
    end

    def escapeHTML(str); str end
    name { repo.capitalize }
    rubygem { repo }
  end
end
