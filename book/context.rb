require 'gutenberg/mixins'

Gutenberg.new do
  def repo; 'gutenberg' end
  def user; 'somu'      end
  
  def structure
    read 'book/structure.md'
  end

  def mustache_introduction; '`{{introduction}}`' end
  def mustache_header;       '`{{head}}`'         end

  load 'examples/*'
  include Gutenberg::Mixins
end
