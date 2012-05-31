# encoding: utf-8

module Veritas
  module Algebra

    # The intersection between relations
    class Intersection < Relation
      include Relation::Operation::Set

      # Iterate over each tuple in the set
      #
      # @example
      #   intersection = Intersection.new(left, right)
      #   intersection.each { |tuple| ... }
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
        left.each { |tuple| yield tuple if right_set.include?(tuple) }
        self
      end

      # Insert a relation into the Intersection
      #
      # @example
      #   new_relation = intersection.insert(other)
      #
      # @param [Relation] other
      #
      # @return [Intersection]
      #
      # @api public
      def insert(other)
        insert_left(other).intersect(insert_right(other))
      end

      # Delete a relation from the Intersection
      #
      # @example
      #   new_relation = intersection.delete(other)
      #
      # @param [Relation] other
      #
      # @return [Intersection]
      #
      # @api public
      def delete(other)
        delete_left(other).intersect(delete_right(other))
      end

      module Methods
        extend Aliasable

        inheritable_alias(:& => :intersect)

        # Return the intersection between relations
        #
        # @example
        #   intersection = relation.intersect(other)
        #
        # @param [Relation] other
        #
        # @return [Intersection]
        #
        # @api public
        def intersect(other)
          Intersection.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Intersection
  end # module Algebra
end # module Veritas
