module Veritas
  class Attribute
    class Time < Object
      include Comparable

      RANGE = ::Time.at(0)..::Time.at(2**31-1)

      def range
        RANGE
      end

      def self.primitive
        ::Time
      end
    end # class Time
  end # class Attribute
end # module Veritas
