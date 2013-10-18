require 'optparse'

module Gutenberg
  class Parser
    def initialize
      @options = {}
      @parser = OptionParser.new do |parser|
        @parser = parser
        methods.delete_if { |m| not m.to_s.start_with? 'parse_'}.sort.each { |m| send m }
      end
    end

    def on(*args, &block)
      @parser.on(*args, &block)
    end

    def parse
      @parser.parse!
      @options
    end

    include Options
  end
end
