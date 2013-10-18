module Gutenberg
  module Mixins
    module Links
      def documentation
        "[**Documentation**](http://rubydoc.info/github/#{user}/#{repo}/master/frames)"
      end

      def rubygems
        "[**Gem**](http://rubygems.org/gems/#{rubygem})"
      end

      def header
        line = '=' * name.length
        "#{name}\n#{line}"
      end

      def semver
        "[semantic versioning](http://semver.org)"
      end

      def repo_url
        "https://github.com/#{user}/#{repo}/tree/master/"
      end

      alias repourl repo_url
    end
  end
end
