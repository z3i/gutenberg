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

    def parse_structure
      on '-s', '--structure <pattern>', 'Specify structure pattern' do |pattern|
        set :structure, pattern
      end
    end

    def parse_file
      on '-f', '--file <path>', 'Change resulting file name, README.md by default' do |path|
        set :file, path
      end
    end

    def parse_pattern
      on '-p', '--pattern <pattern>', 'Specify including file matching pattern' do |pattern|
        set :pattern, pattern
      end
    end

    def parse_context
      on '-c', '--context <path>', 'Specify context file' do |path|
        set :context, context
      end
    end

    def parse_no_mixins
      on '--no-mixins', 'Do not include mixins' do
        set :mixins, Array.new
      end
    end
  end
end
