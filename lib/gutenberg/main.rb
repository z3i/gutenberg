module Gutenberg
  def self.new(directory = 'book', structure = "#{directory}/structure.md", pattern = "#{directory}/*.md", &block)
    context = Class.new(Context)
    context.load(pattern, structure)
    context.class_eval(&block) if block_given?
    context.template_file = structure
    $stdout.puts context.render
  end
end
