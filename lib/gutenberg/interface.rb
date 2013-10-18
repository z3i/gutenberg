module Gutenberg
  class Interface
    def initialize(directory   = 'book',
                   structure   = "#{directory}/structure.*",
                   file        = 'README' << File.extname(Dir[structure].first),
                   pattern     = "#{directory}/*.*",
                   context     = "#{directory}/context.*",
                   mixins      = Gutenberg::Mixins
                   &block)
      @directory = directory
      @structure = structure
      @file      = file
      @pattern   = pattern
      @context   = fetch(context)
      @mixins    = mixins
    end

    def fetch(pattern)
      contexts = Dir[pattern]
      contexts.empty? ? nil : contexts.first
    end

    def write(&block)
      original = $stdout.clone
      $stdout.reopen File.open(@file, 'w+')
      yield
      $stdout.reopen original
    end

    def include_mixins
      @mixins.each { |m| include m }
    end

    def context_with(hash)
      Gutenberg.new {
        hash.each do |k,v|
          define_method(k) { v }
        end
        include_mixins
      }
    end

    def load_via(engine)
      engine.send :load, File.read(@context)
    end

    def inject
      return Gutenberg.new { include_mixins } unless @context
      case File.extname(@context)
      when '.rb'
        require './' << @context
      when '.yml'
        require 'yaml'
        context_with load_via YAML
      when '.json'
        require 'json'
        context_with load_via JSON
      end
    end

    def process
      write { inject }
    end

    def run
      Parser.new.parse.each do |o,v|
        instance_variable_set "@#{o}", v
      end
      process
    end

    def self.run(*args)
      new(*args).run
    end
  end
end
