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
        url = "https://gemnasium.com/#{user}/#{repo}"
        "[![Dependency status](#{url}.png)](#{url})"
      end

      def codeclimate
        url = "https://codeclimate.com/github/#{user}/#{repo}"
        "[![Code readability](#{url}.png)](#{url})"
      end

      def gittip
        "[![Gittip](http://img.shields.io/Gittip/#{user}.png)](https://www.gittip.com/#{user}/)"
      end

      alias code_climate codeclimate
      alias gemversion gem_version
      alias travis_ci travis
      alias travisci travis
      alias git_tip gittip
    end
  end
end
