require 'gutenberg/mixins/badges'
require 'gutenberg/mixins/links'
require 'gutenberg/mixins/methods'

module Gutenberg
  module Mixins
    constants.each do |constant|
      constant = Gutenberg::Mixins.const_get constant
      include constant if constant.instance_of? Module
    end
  end
end
