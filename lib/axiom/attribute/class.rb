# encoding: utf-8

module Axiom
  class Attribute

    # Represents a Class value in a relation tuple
    class Class < Object

      # The Class primitive
      #
      # @example
      #   Class.primitive  # => ::Class
      #
      # @return [Class<::Class>]
      #
      # @api public
      def self.primitive
        ::Class
      end

    end # class Class
  end # class Attribute
end # module Axiom
