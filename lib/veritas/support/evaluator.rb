# encoding: utf-8

module Veritas
  module Evaluator

    # Provide a context to evaluate a Relation operation block
    class Context
      include Immutable

      # The functions to evaluate
      #
      # @return [Hash]
      #
      # @api private
      attr_reader :functions

      # Initialize a Context
      #
      # @param [Header] header
      #
      # @return [undefined]
      #
      # @api private
      def initialize(header)
        @header    = header
        @functions = {}
        yield self
        @functions.freeze
      end

      # Add a function to be evaluated by the relation operation
      #
      # @example of a function
      #   context.add(:total, context[:unit_price] * context[:quantity])
      #
      # @example of a block
      #   context.add(:total) { |tuple| tuple[:unit_price] * tuple[:quantity] } }
      #
      # @param [Attribute, #to_ary, #to_sym] attribute
      #   the attribute to add to the header
      # @param [#call] function
      #   optional function
      #
      # @yield []
      #   optional block to execute in the relation operation
      #
      # @return [self]
      #
      # @api public
      def add(attribute, function = nil, &block)
        functions[Attribute.coerce(attribute)] = function || block
        self
      end

      # Lookup the attribute in the header
      #
      # @example
      #   attribute = context[name]
      #
      # @param [Symbol]
      #
      # @return [Attribute]
      #
      # @api public
      def [](name)
        @header[name]
      end

    end # class Context
  end # module Evaluator
end # module Veritas
