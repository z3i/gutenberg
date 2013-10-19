module Gutenberg
  module Generator
    def parse_init
      on '-i', '--init', 'Initialize a project' do 
        dir       = @options[:directory] || 'book'
        context   = "#{dir}/context.yml"
        structure = "#{dir}/structure.md"
        
        require 'fileutils'
        try_mkdir dir
        try_touch context
        try_touch structure
        try_open(context,   'w') { |f| f.puts "repo: #{File.basename(pwd)}\nuser: #{`whoami`.chomp}" }
        try_open(structure, 'w') { |f| f.puts File.read File.dirname(__FILE__) << '/../../examples/structure_example.md' }

        puts 'Scaffolding generated!'
        exit
      end
    end

    @@printer = lambda { |name, message| spaces = 25 - name.length; puts "#{name}#{'.' * spaces}#{message}" }

    %w[touch mkdir open].each do |m|
      define_method "try_#{m}" do |*args|
        begin
          FileUtils.send m, *args
          @@printer.call(args.first, 'OK')
        rescue => e
          @@printer.call(args.first, e)
          abort "<= Can’t proceed! Fix the error above.\n"
        end
      end
    end
  end
end
