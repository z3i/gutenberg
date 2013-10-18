Gutenberg.new do
  repo 'gutenberg'
  user 'somu'

  structure read 'book/structure.md'
  options `./bin/gutenberg -h`

  mustache_introduction '`{{introduction}}`'
  mustache_header       '`{{head}}`'

  load 'examples/*'
end
