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

      # Insert a relation into the Restriction
      #
      # The other relation must match the predicate to be inserted.
      #
      # @example
      #   new_relation = restriction.insert(other)
      #
      # @param [Relation] other
      #
      # @return [Restriction]
      #
      # @api public
      def insert(other)
        predicate = self.predicate
        operand.insert(other.restrict(predicate)).restrict(predicate)
      end

      # Delete a relation from the Restriction
      #
      # The other relation must match the predicate to be deleted.
      #
      # @example
      #   new_relation = restriction.delete(other)
      #
      # @param [Relation] other
      #
      # @return [Restriction]
      #
      # @api public
      def delete(other)
        predicate = self.predicate
        operand.delete(other.restrict(predicate)).restrict(predicate)
      end

      module Methods

        # Return a relation with restricted tuples
        #
        # @example restriction with a predicate
        #  restriction = relation.restrict(predicate)
        #
        # @example restriction using a block
        #   restriction = relation.restrict do |context|
        #     context.a.eq('other').and(context.b.gte(42))
        #   end
        #
        # @param [Array] *args
        #   optional arguments
        #
        # @yield [context]
        #   optional block to restrict the tuples with
        #
        # @yieldparam [Evaluator::Context] context
        #   the context to evaluate the restriction with
        #
        # @yieldreturn [Function, #call]
        #   predicate to restrict the tuples with
        #
        # @return [Restriction]
        #
        # @api public
        def restrict(*args, &block)
          Restriction.new(self, coerce_to_predicate(*args, &block))
        end

      private

        # Coerce the arguments and block into a predicate
        #
        # @param [Function, #call] predicate
        #   optional predicate
        #
        # @yield [relation]
        #   optional block to restrict the tuples with
        #
        # @yieldparam [Evaluator::Context] context
        #   the context to evaluate the restriction with
        #
        # @yieldreturn [Function, #call]
        #   predicate to restrict the tuples with
        #
        # @return [Function, #call]
        #
        # @api private
        def coerce_to_predicate(predicate = Undefined)
          if predicate.equal?(Undefined)
            Evaluator::Context.new(header) { |context| yield context }.yield
          else
            predicate
          end
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Restriction
  end # module Algebra
end # module Veritas
