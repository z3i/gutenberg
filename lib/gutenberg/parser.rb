require 'optparse'

module Gutenberg
  class Parser
    def initialize
      @options = {}
      @parser = OptionParser.new do |parser|
        @parser = parser
        methods.delete_if { |m| not m.to_s.start_with? 'parse_'}.each { |m| send m }
      end
    end

    def on(*args, &block)
      @parser.on(*args, &block)
    end

    def parse
      @parser.parse!
      @options
    end

    def parse_help
      on('-h', '--help', 'Prints this message out') do
        puts @parser
        exit
      end
    end

    def parse_version
      on('-v', '--version', 'Prints Gutenberg version') do
        puts Gutenberg::VERSION
        exit
      end
    end
  end
end
