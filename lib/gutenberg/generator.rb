module Gutenberg
  module Generator
    def parse_init
      on '-i', '--init', 'Initialize a project' do 
        directory = @options[:directory] || 'book'
        context   = "#{directory}/context.yml"
        structure = "#{directory}/structure.md"

        require 'fileutils'
        repo = File.basename(FileUtils.pwd)
        user = `whoami`.chomp
        
        try_mkdir directory
        try_touch context
        try_touch structure
        try_open(context,   'w') { |f| f.puts "repo: #{repo}\nuser: #{user}" }
        try_open(structure, 'w') { |f| f.puts File.read File.dirname(__FILE__) << '/../structure.md' }

        puts 'Scaffolding generated!'
        exit
      end
    end

    @@printer = lambda do |method, name, message|
      name_dots     = '.' * (30 - name.length)
      method_spaces = ' ' * (6  - method.length)
      puts '#' << method << method_spaces << name << name_dots << message
    end

    %w[touch mkdir open].each  do |m|
      define_method "try_#{m}" do |*args, &block|
        to_print = [m, args.first]
        begin
          FileUtils.send m, *args, &block
          to_print << 'OK'
        rescue => e
          to_print << e.to_s
          abort "Fix the error:\n"
        ensure
          @@printer.call(*to_print)
        end
      end
    end
  end
end
