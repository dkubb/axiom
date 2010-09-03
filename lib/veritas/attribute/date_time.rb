module Veritas
  class Attribute
    class DateTime < Object
      include Comparable

      RANGE = ::DateTime.new..::DateTime::Infinity.new

      def range
        RANGE
      end

      def self.primitive
        ::DateTime
      end

    end # class DateTime
  end # class Attribute
end # module Veritas
