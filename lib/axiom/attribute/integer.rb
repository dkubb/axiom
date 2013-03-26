# encoding: utf-8

module Axiom
  class Attribute

    # Represents an Integer value in a relation tuple
    class Integer < Numeric

      # The Integer primitive
      #
      # @example
      #   Integer.primitive  # => ::Integer
      #
      # @return [Class<::Integer>]
      #
      # @api public
      def self.primitive
        ::Integer
      end

    end # class Integer
  end # class Attribute
end # module Axiom
