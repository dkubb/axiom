module Veritas
  module Algebra

    # Restrict the tuples to those that match a predicate
    class Restriction < Relation
      include Relation::Operation::Unary

      # The predicate for the relation
      #
      # @return [Expression, #call]
      #
      # @api private
      attr_reader :predicate

      # Initialize a Restriction
      #
      # @param [Relation] operand
      #   the relation to restrict
      # @param [Expression, #call] predicate
      #   the expression to restrict the tuples with
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
        operand.each { |tuple| yield(tuple) if predicate.call(tuple) }
        self
      end

      # Compare the Restriction with other relation for equality
      #
      # @example
      #   restriction.eql?(other)  # => true or false
      #
      # @param [Relation] other
      #   the other relation to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        super && predicate.eql?(other.predicate)
      end

      module Methods

        # Return a relation with restricted tuples
        #
        # @example restriction using a predicate
        #   restriction = relation.restrict(relation.name.eq('other'))
        #
        # @example restriction using a block
        #   restriction = relation.restrict { |r| r[:a].eq('other').and(r[:b].gte(42)) }
        #
        # @param [Expression, #call] predicate
        #   optional predicate to restrict the tuples with
        #
        # @yield [relation]
        #   optional block to restrict the tuples with
        #
        # @yieldparam [Relation] relation
        #   the context to evaluate the restriction with
        #
        # @return [Restriction]
        #
        # @api public
        def restrict(predicate = yield(self))
          Restriction.new(self, predicate)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Restriction
  end # module Algebra
end # module Veritas
