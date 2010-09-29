module Veritas
  class Attribute

    # Represents a Float value in a relation tuple
    class Float < Numeric

      # The Float primitive
      #
      # @example
      #   Float.primitive  # => ::Float
      #
      # @return [Class<::Float>]
      #
      # @api public
      def self.primitive
        ::Float
      end

    end # class Float
  end # class Attribute
end # module Veritas
