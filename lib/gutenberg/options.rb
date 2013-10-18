module Gutenberg
  module Options
    def parse_help
      on '-h', '--help', 'Prints this message out' do
        puts @parser
        exit
      end
    end

    def parse_version
      on '-v', '--version', 'Prints Gutenberg version' do
        puts 'Gutenberg ' << Gutenberg::VERSION
        exit
      end
    end

    def parse_directory
      on '-d', '--directory <path>', 'Specify documentation directory' do |path|
        set :directory, path
      end
    end
  end
end
