# encoding: utf-8

module Axiom
  class Function

    # Abstract base class for logical connectives
    class Connective < Function
      include AbstractType

      # Return the type returned from #call
      #
      # @example
      #   type = Axiom::Function::Connective.type  # => Axiom::Types::Boolean
      #
      # @return [Class<Types::Boolean>]
      #
      # @api public
      def self.type
        Types::Boolean
      end

    end # class Connective
  end # class Function
end # module Axiom
