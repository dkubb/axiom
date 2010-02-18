module Veritas
  class Attribute
    class Numeric < Object
      include Comparable

      attr_reader :size

      def initialize(name, options = {})
        super
        @size = options.fetch(:size, 0..2**31-1)
      end
    end # class Numeric
  end # class Attribute
end # module Veritas
