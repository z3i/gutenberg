Gutenberg.new do
  repo 'gutenberg'
  user 'somu'

  self_structure { read 'book/structure.md'  }
  self_context   { read 'book/context.rb'    }
  
  options `./bin/gutenberg -h`.chomp

  mustache_introduction '`{{introduction}}`'
  mustache_header       '`{{head}}`'

  load 'examples/*'
end
