Gutenberg.new do
  repo 'gutenberg'
  user 'somu'

  self_structure { read 'book/structure.md'  }
  self_context   { read 'book/context.rb'    }

  describe_mixins do
    meths = Hash.new
    Dir['lib/gutenberg/mixins/*.rb'].each do |f|
      name = nil
      file = File.read(f)
      file.gsub(/module (\w+)/) { name = $1 }
      meths[name] = Array.new

      file.gsub(/def (\w+)/) { meths[name] << $1 }
    end
    output = ''
    meths.each do |n,ms|
      output << "#### #{n}\n\n"
      ms.each { |m| output << "+ `{{#{m}}}`\n"}
      output << "\n"
    end
    output
  end

  options `./bin/gutenberg -h`.chomp

  mustache_introduction '`{{introduction}}`'
  mustache_header       '`{{head}}`'

  load 'examples/*'
end
