# encoding: utf-8

module Axiom
  module Algebra

    # The join between relations
    class Join < Relation
      include Relation::Operation::Combination

      # The common headers between the operands
      #
      # @return [Header]
      #
      # @api private
      attr_reader :join_header

      # Initialize a Join
      #
      # @param [Relation] _left
      # @param [Relation] _right
      #
      # @return [undefined]
      #
      # @api private
      def initialize(_left, _right)
        super
        right_header     = right.header
        @join_header     = left.header  & right_header
        @disjoint_header = right_header - join_header
      end

      # Iterate over each tuple in the set
      #
      # @example
      #   join = Join.new(left, right)
      #   join.each { |tuple| ... }
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the set
      #
      # @return [self]
      #
      # @api public
      def each(&block)
        return to_enum unless block_given?
        util  = Relation::Operation::Combination
        index = build_index
        left.each do |left_tuple|
          util.combine_tuples(header, left_tuple, index[left_tuple], &block)
        end
        self
      end

      # Insert a relation into the Join
      #
      # @example
      #   new_relation = join.insert(other)
      #
      # @param [Relation] other
      #
      # @return [Join]
      #
      # @api public
      def insert(other)
        other = coerce(other)
        insert_left(other).join(insert_right(other))
      end

      # Delete a relation from the Join
      #
      # @example
      #   new_relation = join.delete(other)
      #
      # @param [Relation] other
      #
      # @return [Join]
      #
      # @api public
      def delete(other)
        other = coerce(other)
        delete_left(other).join(delete_right(other))
      end

    private

      # Build an index using every tuple in the right relation
      #
      # @return [Hash]
      #
      # @api private
      def build_index
        Index.new(join_header, @disjoint_header).merge(right)
      end

      # Insert the other relation into the left operand
      #
      # @param [Relation] other
      #
      # @return [Relation::Operation::Insertion]
      #
      # @api private
      def insert_left(other)
        left.insert(other.project(left.header))
      end

      # Insert the other relation into the right operand
      #
      # @param [Relation] other
      #
      # @return [Relation::Operation::Insertion]
      #
      # @api private
      def insert_right(other)
        right.insert(other.project(right.header))
      end

      # Delete the other relation from the left operand
      #
      # @param [Relation] other
      #
      # @return [Relation::Operation::Deletion]
      #
      # @api private
      def delete_left(other)
        left.delete(other.project(left.header))
      end

      # Delete the other relation from the right operand
      #
      # @param [Relation] other
      #
      # @return [Relation::Operation::Deletion]
      #
      # @api private
      def delete_right(other)
        right.delete(other.project(right.header))
      end

      module Methods
        extend Aliasable

        inheritable_alias(:+ => :join)

        # Return a relation that is the join of two relations
        #
        # @example natural join
        #   join = relation.join(other)
        #
        # @example theta-join using a block
        #   join = relation.join(other) { |r| r.a.gte(r.b) }
        #
        # @param [Relation] other
        #   the other relation to join
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
        # @return [Join, Restriction]
        #
        # @api public
        def join(other, &block)
          relation = Join.new(self, other)
          relation = relation.restrict(&block) if block
          relation
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Join
  end # module Algebra
end # module Axiom
