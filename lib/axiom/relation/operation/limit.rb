# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing a limited relation
      class Limit < Relation
        include Unary
        include Equalizer.new(:operand, :limit)

        # Return the limit
        #
        # @example
        #   limit = limited_relation.limit
        #
        # @return [Integer]
        #
        # @api public
        attr_reader :limit

        # The relation sort order
        #
        # @return [Operation::Order::DirectionSet]
        #
        # @api private
        attr_reader :directions

        # Instantiate a new Limit
        #
        # @example
        #   limited_relation = Limit.new(operand, limit)
        #
        # @param [Relation] operand
        #   the relation to limit
        # @param [Integer] limit
        #   the maximum number of tuples in the limited relation
        #
        # @return [Limit]
        #
        # @api public
        def self.new(operand, limit)
          assert_ordered_operand(operand)
          assert_valid_limit(limit)
          super
        end

        # Assert the operand is ordered
        #
        # @param [Relation] operand
        #
        # @return [undefined]
        #
        # @raise [OrderedRelationRequiredError]
        #   raised if the operand is unordered
        #
        # @api private
        def self.assert_ordered_operand(operand)
          if operand.header.to_ary.size != operand.directions.to_ary.size
            raise OrderedRelationRequiredError, 'can only limit an ordered operand'
          end
        end

        # Assert the limit is valid
        #
        # @param [Integer] limit
        #
        # @return [undefined]
        #
        # @raise [InvalidLimitError]
        #   raised if the limit is less than 0
        #
        # @api private
        def self.assert_valid_limit(limit)
          if limit.nil? || limit < 0
            raise InvalidLimitError, "limit must be greater than or equal to 0, but was #{limit.inspect}"
          end
        end

        private_class_method :assert_ordered_operand, :assert_valid_limit

        # Initialize a Limit
        #
        # @param [Relation] operand
        #   the relation to limit
        # @param [Integer] limit
        #   the maximum number of tuples in the limited relation
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operand, limit)
          super(operand)
          @limit      = limit
          @directions = operand.directions
        end

        # Iterate over each tuple in the set
        #
        # @example
        #   limited_relation = Limit.new(operand, limit)
        #   limited_relation.each { |tuple| ... }
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
          operand.each_with_index do |tuple, index|
            break if @limit == index
            yield tuple
          end
          self
        end

        # Raise an exception when inserting into the Limit
        #
        # @example
        #   limit.insert(other)  # => ImmutableRelationError raised
        #
        # @return [undefined]
        #
        # @raise [ImmutableRelationError]
        #   raised when inserting into the limit
        #
        # @api public
        def insert(*)
          raise ImmutableRelationError, 'inserting into a limit is impossible'
        end

        # Raise an exception when deleting from the Limit
        #
        # @example
        #   limit.delete(other)  # => ImmutableRelationError raised
        #
        # @return [undefined]
        #
        # @raise [ImmutableRelationError]
        #   raised when deleting from the limit
        #
        # @api public
        def delete(*)
          raise ImmutableRelationError, 'deleting from a limit is impossible'
        end

        module Methods

          # Default block used in #one
          DEFAULT_ONE_BLOCK = -> { }

          # Maximum number of tuples to take in #one
          ONE_LIMIT = 2

          # Return a relation with n tuples
          #
          # @example
          #   limited_relation = relation.take(5)
          #
          # @param [Integer] limit
          #   the maximum number of tuples in the limited relation
          #
          # @return [Limit]
          #
          # @api public
          def take(limit)
            Limit.new(self, limit)
          end

          # Return a relation with the first n tuples
          #
          # @example with no limit
          #   limited_relation = relation.first
          #
          # @example with a limit
          #   limited_relation = relation.first(5)
          #
          # @param [Integer] limit
          #   optional number of tuples from the beginning of the relation
          #
          # @return [Limit]
          #
          # @api public
          def first(limit = 1)
            take(limit)
          end

          # Return a relation with the last n tuples
          #
          # @example with no limit
          #   limited_relation = relation.last
          #
          # @example with a limit
          #   limited_relation = relation.last(5)
          #
          # @param [Integer] limit
          #   optional number of tuples from the end of the relation
          #
          # @return [Limit]
          #
          # @api public
          def last(limit = 1)
            reverse.take(limit).reverse
          end

          # Return a tuple if the relation contains exactly one tuple
          #
          # @example without a block
          #   tuple = relation.one
          #
          # @example with a block
          #   tuple = relation.one { ... }
          #
          # @yieldreturn [Object]
          #
          # @return [Tuple]
          #
          # @raise [NoTuplesError]
          #   raised if no tuples are returned
          # @raise [ManyTuplesError]
          #   raised if more than one tuple is returned
          #
          # @api public
          def one(&block)
            block ||= DEFAULT_ONE_BLOCK
            tuples = take(ONE_LIMIT).to_a
            assert_no_more_than_one_tuple(tuples.size)
            tuples.first or block.yield or
              raise NoTuplesError, 'one tuple expected, but was an empty set'
          end

        private

          # Assert no more than one tuple is returned
          #
          # @return [undefined]
          #
          # @raise [ManyTuplesError]
          #   raised if more than one tuple is returned
          #
          # @api private
          def assert_no_more_than_one_tuple(size)
            if size > 1
              raise(
                ManyTuplesError,
                "one tuple expected, but set contained #{count} tuples"
              )
            end
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Limit
    end # module Operation
  end # class Relation
end # module Axiom
