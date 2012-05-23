# encoding: utf-8

module Veritas
  module Algebra

    # Restrict the tuples to those that match a predicate
    class Restriction < Relation
      include Relation::Operation::Unary
      include Equalizer.new(:operand, :predicate)

      # The predicate for the relation
      #
      # @return [Function, #call]
      #
      # @api private
      attr_reader :predicate

      # Initialize a Restriction
      #
      # @param [Relation] operand
      #   the relation to restrict
      # @param [Function, #call] predicate
      #   the function to restrict the tuples with
      #
      # @return [undefined]
      #
      # @api private
      def initialize(operand, predicate)
        super(operand)
        @predicate = predicate
      end

      # Iterate over each tuple in the set
      #
      # @example
      #   restriction = Restriction.new(operand, predicate)
      #   restriction.each { |tuple| ... }
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the set
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        operand.each do |tuple|
          yield tuple if Function.extract_value(predicate, tuple).equal?(true)
        end
        self
      end

      module Methods

        # Return a relation with restricted tuples
        #
        # @example restriction using a block
        #   restriction = relation.restrict { |r| r.a.eq('other').and(r.b.gte(42)) }
        #
        # @yield [relation]
        #   optional block to restrict the tuples with
        #
        # @yieldparam [Relation] relation
        #   the context to evaluate the restriction with
        #
        # @yieldreturn [Function, #call]
        #   predicate to restrict the tuples with
        #
        # @return [Restriction]
        #
        # @api public
        def restrict
          context = Evaluator::Context.new(header) { |context| yield context }
          Restriction.new(self, context.yield)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Restriction
  end # module Algebra
end # module Veritas
