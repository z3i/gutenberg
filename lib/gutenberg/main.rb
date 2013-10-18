module Gutenberg
  def self.new(directory = 'book', structure = "#{directory}/structure.*", pattern = "#{directory}/*.md", &block)
    context = Class.new(Context)
    context.load(pattern, structure)
    context.class_eval(&block) if block_given?
    context.template_file = Dir[structure].first
    $stdout.puts context.render
  end
end
