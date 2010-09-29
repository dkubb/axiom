module Veritas
  class Attribute
    class DateTime < Object
      include Comparable

      DEFAULT_RANGE = (::DateTime.new..::DateTime::Infinity.new).freeze

      def self.primitive
        ::DateTime
      end

      def range
        DEFAULT_RANGE
      end

    end # class DateTime
  end # class Attribute
end # module Veritas
