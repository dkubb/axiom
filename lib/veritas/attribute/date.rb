module Veritas
  class Attribute
    class Date < Object
      include Comparable

      DEFAULT_RANGE = (::Date.new..::Date::Infinity.new).freeze

      def self.primitive
        ::Date
      end

      def range
        DEFAULT_RANGE
      end

    end # class Date
  end # class Attribute
end # module Veritas
