require 'gutenberg/mixins'

class View < Gutenberg::View
  def repo; 'gutenberg' end
  def user; 'somu' end
  
  def structure
    File.read('book/structure.md').chomp
  end

  def introduction_variable
    '`{{introduction}}`'
  end

  def header_variable
    '`{{head}}`'
  end

  load 'examples/*'
  include Gutenberg::Mixins
end
