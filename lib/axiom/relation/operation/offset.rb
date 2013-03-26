# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing an offset relation
      class Offset < Relation
        include Unary
        include Equalizer.new(:operand, :offset)

        # Return the offset
        #
        # @example
        #   offset = offset_relation.offset
        #
        # @return [Integer]
        #
        # @api public
        attr_reader :offset

        # The relation sort order
        #
        # @return [Operation::Order::DirectionSet]
        #
        # @api private
        attr_reader :directions

        # Instantiate a new Offset
        #
        # @example
        #   offset_relation = Offset.new(operand, offset)
        #
        # @param [Relation] operand
        #   the relation to offset
        # @param [Integer] offset
        #   the offset of the operand to drop
        #
        # @return [Offset]
        #
        # @api public
        def self.new(operand, offset)
          assert_ordered_operand(operand)
          assert_valid_offset(offset)
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
            raise OrderedRelationRequiredError, 'can only offset an ordered operand'
          end
        end

        # Assert the offset is valid
        #
        # @param [Integer] offset
        #
        # @return [undefined]
        #
        # @raise [InvalidOffsetError]
        #   raised if the offset is less than 0
        #
        # @api private
        def self.assert_valid_offset(offset)
          if offset.nil? || offset < 0
            raise InvalidOffsetError, "offset must be greater than or equal to 0, but was #{offset.inspect}"
          end
        end

        private_class_method :assert_ordered_operand, :assert_valid_offset

        # Initialize an Offset
        #
        # @param [Relation] operand
        #   the relation to offset
        # @param [Integer] offset
        #   the offset of the operand to drop
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operand, offset)
          super(operand)
          @offset     = offset
          @directions = operand.directions
        end

        # Iterate over each tuple in the set
        #
        # @example
        #   offset_relation = Offset.new(operand, offset)
        #   offset_relation.each { |tuple| ... }
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
            yield tuple if index >= @offset
          end
          self
        end

        # Raise an exception when inserting into the Offset
        #
        # @example
        #   offset.insert(other)  # => ImmutableRelationError raised
        #
        # @return [undefined]
        #
        # @raise [ImmutableRelationError]
        #   raised when inserting into the offset
        #
        # @api public
        def insert(*)
          raise ImmutableRelationError, 'inserting into an offset is impossible'
        end

        # Raise an exception when deleting from the Offset
        #
        # @example
        #   offset.delete(other)  # => ImmutableRelationError raised
        #
        # @return [undefined]
        #
        # @raise [ImmutableRelationError]
        #   raised when deleting from the offset
        #
        # @api public
        def delete(*)
          raise ImmutableRelationError, 'deleting from an offset is impossible'
        end

        module Methods

          # Return a relation with n tuples
          #
          # @example
          #   offset_relation = relation.drop(5)
          #
          # @param [Integer] offset
          #   the offset of the relation to drop
          #
          # @return [Offset]
          #
          # @api public
          def drop(offset)
            Offset.new(self, offset)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Offset
    end # module Operation
  end # class Relation
end # module Axiom
