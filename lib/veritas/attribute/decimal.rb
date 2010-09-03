module Veritas
  class Attribute
    class Decimal < Numeric
      def self.primitive
        ::BigDecimal
      end

    end # class Decimal
  end # class Attribute
end # module Veritas
