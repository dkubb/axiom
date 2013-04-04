# encoding: utf-8

module Axiom
  module Algebra

    # The union between relations
    class Union < Relation
      include Relation::Operation::Set

      # Iterate over each tuple in the set
      #
      # @example
      #   union = Union.new(left, right)
      #   union.each { |tuple| ... }
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
        seen = Hash.new
        left.each  { |tuple| yield seen[tuple] = tuple           }
        right.each { |tuple| yield tuple unless seen.key?(tuple) }
        self
      end

      # Insert a relation into the Union
      #
      # @example
      #   new_relation = union.insert(other)
      #
      # @param [Relation] other
      #
      # @return [Union]
      #
      # @api public
      def insert(other)
        left.insert(other).union(right.insert(other))
      end

      # Delete a relation from the Union
      #
      # @example
      #   new_relation = union.delete(other)
      #
      # @param [Relation] other
      #
      # @return [Union]
      #
      # @api public
      def delete(other)
        left.delete(other).union(right.delete(other))
      end

      module Methods
        extend Aliasable

        inheritable_alias(:| => :union)

        # Return the union between relations
        #
        # @example
        #   union = relation.union(other)
        #
        # @param [Relation] other
        #
        # @return [Union]
        #
        # @api public
        def union(other)
          Union.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Union
  end # module Algebra
end # module Axiom
