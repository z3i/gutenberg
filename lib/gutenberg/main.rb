module Gutenberg
  class << self
    attr_writer :mixins

    def new(directory   = 'book',
            structure   = "#{directory}/structure.*",
            called_from = "#{directory}/context.*",
            pattern     = "#{directory}/*.*",
            &block)
      context = Class.new(Context)
      context.include_mixins(@mixins)
      context.load pattern, [called_from, structure]
      context.class_eval(&block) if block_given?
      context.template_file = Dir[structure].first
      $stdout.puts context.render
      self.mixins = nil
    end
  end
end
