module Veritas
  class Attribute
    class Date < Object
      include Comparable

      RANGE = ::Date.new..::Date::Infinity.new

      def range
        RANGE
      end

      def self.primitive
        ::Date
      end
    end # class Date
  end # class Attribute
end # module Veritas
