# encoding: utf-8

module Axiom
  class Function

    # Abstract class for Numeric functions
    class Numeric < Function
      include AbstractType

      # Return the type returned from #call
      #
      # @example
      #   type = Axiom::Function::Numeric.type  # => Axiom::Types::Numeric
      #
      # @return [Class<Types::Numeric>]
      #
      # @api public
      def self.type
        Types::Numeric
      end

    end # class Numeric
  end # class Function
end # module Axiom
