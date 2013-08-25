require 'gutenberg/mixins'

class View < Gutenberg::View
  def repo; 'gutenberg' end
  def user; 'somu' end

  load 'examples/*.rb'
  include Gutenberg::Mixins
end
