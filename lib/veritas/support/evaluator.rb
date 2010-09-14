module Veritas
  module Evaluator
    class Expression
      include Immutable

      attr_reader :expressions

      def initialize
        @expressions = {}
        yield self
      end

      def add(attribute, expression = nil, &block)
        expressions[attribute] = expression || block
        self
      end

    end # class FunctionExpression
  end # module Evaluator
end # module Veritas
