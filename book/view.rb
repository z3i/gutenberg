require 'gutenberg/mixins'

class View < Gutenberg::View
  def repo; 'gutenberg' end
  def user; 'somu' end

  include Gutenberg::Mixins
end
