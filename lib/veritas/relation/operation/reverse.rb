module Veritas
  class Relation
    module Operation

      # A class representing a reverse sorted relation
      class Reverse < Order

        # Instantiate a new Reverse relation
        #
        # @example
        #   reverse = Reverse.new(operand)
        #
        # @param [Relation] operand
        #
        # @return [Reverse]
        #
        # @api public
        def self.new(operand)
          assert_ordered_operand(operand)
          super(operand, operand.directions.reverse)
        end

        # Assert the operand is ordered
        #
        # @param [Relation] operand
        #
        # @return [undefined]
        #
        # @raise [OrderedRelationRequiredError]
        #   raise if the operand is unordered
        #
        # @api private
        def self.assert_ordered_operand(operand)
          if operand.header.to_ary.size != operand.directions.to_ary.size
            raise OrderedRelationRequiredError, 'can only reverse an ordered operand'
          end
        end

        private_class_method :assert_ordered_operand

        # Iterate over each tuple in the set
        #
        # @example
        #   reverse = Reverse.new(operand)
        #   reverse.each { |tuple| ... }
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
          operand.reverse_each(&block)
          self
        end

      private

        module Methods

          # Return the reversed relation
          #
          # @example
          #   reverse = relation.reverse
          #
          # @param [Relation] other
          #
          # @return [Reverse]
          #
          # @api public
          def reverse
            Reverse.new(self)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Limit
    end # module Operation
  end # class Relation
end # module Veritas
