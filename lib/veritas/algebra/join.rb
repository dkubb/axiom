# encoding: utf-8

module Veritas
  module Algebra

    # The join between relations
    class Join < Relation
      include Relation::Operation::Combination

      # Instantiate a new Join
      #
      # @example
      #   join = Join.new(left, right)
      #
      # @param [Relation] left
      # @param [Relation] right
      #
      # @return [Join]
      #
      # @api public
      def self.new(left, right)
        assert_joinable_headers(left, right)
        super
      end

      # Assert the headers have common attributes
      #
      # @param [Relation] left
      # @param [Relation] right
      #
      # @return [undefined]
      #
      # @raise [InvalidHeaderError]
      #   raised if there are no common attributes between the headers
      #
      # @api private
      def self.assert_joinable_headers(left, right)
        if (left.header & right.header).empty?
          raise InvalidHeaderError, 'the headers must have common attributes'
        end
      end

      private_class_method :assert_joinable_headers

      # Initialize a Join
      #
      # @param [Relation] left
      # @param [Relation] right
      #
      # @return [undefined]
      #
      # @api private
      def initialize(left, right)
        super
        right_header      = right.header
        @join_header      = left.header  & right_header
        @remainder_header = right_header - @join_header
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
          right_tuples = index[join_tuple(left_tuple)]
          if right_tuples
            util.combine_tuples(header, left_tuple, right_tuples, &block)
          end
        end

        self
      end

    private

      # Build an index using every tuple in the right relation
      #
      # @return [Hash]
      #
      # @api private
      def build_index
        index = {}

        right.each do |tuple|
          (index[join_tuple(tuple)] ||= Set.new) << remainder_tuple(tuple)
        end

        index
      end

      # Generate a tuple with only the common attributes used for the join
      #
      # @return [Tuple]
      #
      # @api private
      def join_tuple(tuple)
        tuple.project(@join_header)
      end

      # Generate a tuple with the disjoint attributes to use in the join
      #
      # @return [Tuple]
      #
      # @api private
      def remainder_tuple(tuple)
        tuple.project(@remainder_header)
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
        #   join = relation.join(other) { |r| r[:a].gte(r[:b]) }
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
        def join(other)
          if block_given?
            theta_join(other) { |relation| yield relation }
          else
            natural_join(other)
          end
        end

      private

        # Return a relation that is the natural join
        #
        # @param [Relation] other
        #   the other relation to join
        #
        # @return [Join]
        #
        # @api private
        def natural_join(other)
          Join.new(self, other)
        end

        # Return a relation that is a restricted cartesian product
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
        # @return [Restriction]
        #
        # @api private
        def theta_join(other)
          product(other).restrict { |relation| yield relation }
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Join
  end # module Algebra
end # module Veritas
