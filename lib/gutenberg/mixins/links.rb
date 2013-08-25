module Gutenberg
  module Mixins
    module Links
      def documentation
        "[Documentation](http://rubydoc.info/github/#{user}/#{repo}/master/frames)"
      end

      def rubygems
        "[Gem](http://rubygems.org/gems/#{rubygem})"
      end

      def header
        line = '=' * name.length
        "#{name}\n#{line}"
      end
    end
  end
end
