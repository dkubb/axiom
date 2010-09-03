module Veritas
  class Attribute
    class Integer < Numeric
      def self.primitive
        ::Integer
      end

    end # class Integer
  end # class Attribute
end # module Veritas
