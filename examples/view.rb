require 'gutenberg/mixins'

class View < Gutenberg::View
  def repo; 'sword' end
  def user; 'somu'  end

  include Gutenberg::Mixins
end
