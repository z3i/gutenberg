Gutenberg.new do
  repo 'gutenberg'
  user 'somu'

  structure read 'book/structure.md'

  mustache_introduction '`{{introduction}}`'
  mustache_header       '`{{head}}`'

  load 'examples/*'
end
