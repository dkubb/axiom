# encoding: utf-8

module Veritas
  module Algebra

    # The difference between relations
    class Difference < Relation
      include Relation::Operation::Set

      # Iterate over each tuple in the set
      #
      # @example
      #   difference = Difference.new(left, right)
      #   difference.each { |tuple| ... }
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
        right_set = right.to_set
        left.each { |tuple| yield tuple unless right_set.include?(tuple) }
        self
      end

      # Insert a relation into the Difference
      #
      # Add the relation to the left operand, and remove from the right operand
      # so that it not removed by the difference operation.
      #
      # @example
      #   new_relation = difference.insert(other)
      #
      # @param [Relation] other
      #
      # @return [Difference]
      #
      # @api public
      def insert(other)
        right = self.right
        left.insert(coerce(other).difference(right)).difference(right)
      end

      # Delete a relation from the Difference
      #
      # Remove the relation from the left operand, and add it to the right
      # operand so that it is removed by the difference operation.
      #
      # @example
      #   new_relation = difference.delete(other)
      #
      # @param [Relation] other
      #
      # @return [Difference]
      #
      # @api public
      def delete(other)
        right = self.right
        left.delete(coerce(other).difference(right)).difference(right)
      end

      module Methods
        extend Aliasable

        inheritable_alias(:- => :difference)

        # Return the difference between relations
        #
        # @example
        #   difference = relation.difference(other)
        #
        # @param [Relation] other
        #
        # @return [Difference]
        #
        # @api public
        def difference(other)
          Difference.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Difference
  end # module Algebra
end # module Veritas
