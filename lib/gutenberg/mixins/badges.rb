module Gutenberg
  module Mixins
    module Badges
      def travis
        "[![Build status](https://secure.travis-ci.org/#{user}/#{repo}.png?branch=master)]" \
        "(http://travis-ci.org/#{user}/#{repo})"
      end

      def gem_version
        "[![Gem version](https://badge.fury.io/rb/#{rubygem}.png)]" \
        "(http://rubygems.org/gems/#{rubygem})"
      end

      def coveralls
        "[![Coverage status](https://coveralls.io/repos/#{user}/#{repo}/badge.png)]" \
        "(https://coveralls.io/r/#{user}/#{repo})"
      end

      def gemnasium
        url = "https://gemnasium.com/#@user/#@repo"
        "[![Dependency status](#{url}.png)](#{url})"
      end

      def code_climate
        url = "https://codeclimate.com/github/#@user/#@repo"
        "[![Code readability](#{url}.png)](#{url})"
      end
    end
  end
end
