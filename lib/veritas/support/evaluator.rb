module Veritas
  module Evaluator

    # Provide a context to evaluate a Relation operation block
    class Expression
      include Immutable

      # The expressions to evaluate
      #
      # @return [Hash]
      #
      # @api private
      attr_reader :expressions

      # Initialize an Expression
      #
      # @param [Relation] relation
      #
      # @return [undefined]
      #
      # @api private
      def initialize(relation)
        @relation    = relation
        @expressions = {}
        yield self
        @expressions.freeze
      end

      # Add an expression to be evaluated by the relation operation
      #
      # @example of a function
      #   evaluator.add(:total, evaluator[:unit_price] * evaluator[:quantity])
      #
      # @example of a block
      #   evaluator.add(:total) { |t| t[:unit_price] * t[:quantity] } }
      #
      # @param [Attribute, #to_ary, #to_sym] attribute
      #   the attribute to add to the header
      # @param [#call] expression
      #   optional function
      #
      # @yield []
      #   optional block to execute in the relation operation
      #
      # @return [self]
      #
      # @api public
      def add(attribute, expression = nil, &block)
        expressions[Attribute.coerce(attribute)] = expression || block
        self
      end

      # Lookup the attribute in the relation
      #
      # @param [Symbol]
      #
      # @return [Attribute]
      #
      # @api public
      def [](name)
        @relation[name]
      end

    end # class FunctionExpression
  end # module Evaluator
end # module Veritas
