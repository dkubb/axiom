# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Float value in a relation tuple
    class Float < Numeric

      DEFAULT_SIZE = (-::Float::MAX..::Float::MAX).freeze

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
end # module Axiom
