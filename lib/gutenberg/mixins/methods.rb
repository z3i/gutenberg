module Gutenberg
  module Mixins
    module Methods
      def read(file)
        File.read(file).chomp
      end
    end
  end
end
