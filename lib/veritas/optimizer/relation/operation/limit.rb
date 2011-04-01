module Veritas
  class Optimizer
    module Relation
      module Operation

        # Abstract base class representing Limit optimizations
        class Limit < Unary

        private

          # Return the operation limit
          #
          # @return [Integer]
          #
          # @api private
          def limit
            operation.limit
          end

          # Optimize when the limit is zero
          class ZeroLimit < self

            # Test if the limit is zero
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              limit.zero?
            end

            # A Limit with a limit of zero is empty
            #
            # @return [Relation::Empty]
            #
            # @api private
            def optimize
              Veritas::Relation::Empty.new(operation.header)
            end

          end # class ZeroLimit

          # Optimize when the operand is a Limit and the limits are equal
          class EqualLimitOperand < self

            # Test if the operand is a Limit and the limits are equal
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(operation.class) && equal_limit?
            end

            # Flatten equal Limit relations into a single relation
            #
            # @return [Projection]
            #
            # @api private
            def optimize
              operand
            end

          private

            # Test if the operation and operand limits are equal
            #
            # @return [Boolean]
            #
            # @api private
            def equal_limit?
              limit == operand.limit
            end

          end # class EqualLimitOperand

          # Optimize when the operand is a Limit
          class LimitOperand < self

            # Test if the operand is a Limit
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              operand.kind_of?(operation.class)
            end

            # Flatten Limit operations using the minimum limit
            #
            # @return [Boolean]
            #
            # @api private
            def optimize
              operation.class.new(operand.operand, min_limit)
            end

          private

            # Return the minimum limit between the operation and operand
            #
            # @return [Integer]
            #
            # @api private
            def min_limit
              [ limit, operand.limit ].min
            end

          end # class LimitOperand

          # Optimize when operand is optimizable
          class UnoptimizedOperand < self

            # Test if the operand is unoptimized
            #
            # @return [Boolean]
            #
            # @api private
            def optimizable?
              !operand.equal?(operation.operand)
            end

            # Return a Limit with an optimized operand
            #
            # @return [Limit]
            #
            # @api private
            def optimize
              operation.class.new(operand, limit)
            end

          end # class UnoptimizedOperand

          Veritas::Relation::Operation::Limit.optimizer = chain(
            ZeroLimit,
            EqualLimitOperand,
            LimitOperand,
            EmptyOperand,
            MaterializedOperand,
            UnoptimizedOperand
          )

        end # class Limit
      end # module Operation
    end # module Relation
  end # class Optimizer
end # module Veritas
