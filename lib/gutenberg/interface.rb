module Gutenberg
  class Interface
    def initialize(directory   = 'book',
                   structure   = "#{directory}/structure.*",
                   file        = 'README' << File.extname(Dir[structure].first),
                   pattern     = "#{directory}/*.*",
                   context     = "#{directory}/context.*",
                   &block)
      @directory = directory
      @structure = structure
      @file      = file
      @pattern   = pattern
      @context   = fetch(context)
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

    def context_with(hash)
      Gutenberg.new {
        hash.each do |k,v|
          define_method(k) { v }
        end
      }
    end

    def load_via(engine)
      engine.send :load, File.read(@context)
    end

    def inject
      return Gutenberg.new unless @context
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
