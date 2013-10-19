module Gutenberg
  module Generator
    def parse_init
      on '-i', '--init', 'Initialize a project' do 
        directory = @options[:directory] || 'book'
        context   = "#{dir}/context.yml"
        structure = "#{dir}/structure.md"
        
        require 'fileutils'
        try_mkdir directory
        try_touch context
        try_touch structure
        try_open(context,   'w') { |f| f.puts "repo: #{File.basename(FileUtils.pwd)}\nuser: #{`whoami`.chomp}" }
        try_open(structure, 'w') { |f| f.puts File.read File.dirname(__FILE__) << '/../structure.md' }

        puts 'Scaffolding generated!'
        exit
      end
    end

    @@printer = lambda { |name, message| spaces = 25 - name.length; puts "#{name}#{'.' * spaces}#{message}" }

    %w[touch mkdir open].each  do |m|
      define_method "try_#{m}" do |*args, &block|
        begin
          FileUtils.send m, *args, &block
          @@printer.call(args.first, 'OK')
        rescue => e
          @@printer.call(args.first, e)
          abort "<= Can’t proceed! Fix the error above.\n"
        end
      end
    end
  end
end
