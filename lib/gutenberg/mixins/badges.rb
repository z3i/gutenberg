module Gutenberg
  module Mixins
    module Badges
      def travis
        link image('Build status', "https://secure.travis-ci.org/#@user/#@repo.png?branch=master"),
        "http://travis-ci.org/#@user/#@repo"
      end

      def gem_version
        link image('Gem version', "https://badge.fury.io/rb/#@gem.png"),
        "http://rubygems.org/gems/#@gem"
      end

      def coveralls
        link image('Coverage status', "https://coveralls.io/repos/#@user/#@repo/badge.png"),
        "https://coveralls.io/r/#@user/#@repo"
      end

      def gemnasium
        url = "https://gemnasium.com/#@user/#@repo"
        link image('Dependency status', "#{url}.png"), url
      end

      def code_climate
        url = "https://codeclimate.com/github/#@user/#@repo"
        link image('Code readability', "#{url}.png"), url
      end
    end
  end
end
