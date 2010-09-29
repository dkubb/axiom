module Veritas
  class Attribute
    class Time < Object
      include Comparable

      DEFAULT_RANGE = (::Time.at(0)..::Time.at(2**31-1)).freeze

      def self.primitive
        ::Time
      end

      def range
        DEFAULT_RANGE
      end

    end # class Time
  end # class Attribute
end # module Veritas
