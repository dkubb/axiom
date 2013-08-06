# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Class value in a relation tuple
    class Class < Object

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::Class.type  # => Axiom::Types::Class
      #
      # @return [Class<Types::Class>]
      #
      # @api public
      def self.type
        Types::Class
      end

    end # class Class
  end # class Attribute
end # module Axiom
