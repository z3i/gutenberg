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
      $stdout.reopen File.open(file, 'w+')
      yield
      $stdout.reopen original
    end

    def inject
      case File.extname(@context)
      when '.rb'
        require './' << @context
      when '.yml'
        context = YAML.load(@context)
      when '.json'
        context = JSON.load(@context)
      end
    end

    def run
      Parser.new.parser.parse!
    end

    def self.run(*args)
      new(*args).run
    end
  end
end
