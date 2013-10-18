module Gutenberg
  module Mixins
    module Methods
      def read(file)
        File.read(file)
      end
    end
  end
end
