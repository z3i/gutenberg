require 'gutenberg/mixins'

Gutenberg.new do
  def repo; 'sword'     end
  def user; 'somu'      end
  include Gutenberg::Mixins
end
