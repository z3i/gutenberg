module Gutenberg
  module Mixins
    module Methods
      def read(file)
        File.read('book/structure.md').chomp
      end
    end
  end
end
