module Veritas
  module Logic
    class Connective
      class Conjunction < Connective
        include BinaryConnective

        def self.eval(*operands)
          operands.all?
        end

        def optimize
          left, right = optimized_operands

          if always_false?
            Proposition::False.instance
          elsif right.kind_of?(Proposition::True)
            left
          elsif left.kind_of?(Proposition::True)
            right
          elsif collapse_to_exclusion?
            new_exclusion
          else
            super
          end
        end

        def inspect
          "(#{operands.map { |operand| operand.inspect }.join(' AND ')})"
        end

      private

        def always_false?
          optimized_operands.any? do |operand|
            operand.kind_of?(Proposition::False)
          end
        end

        def new_exclusion
          ops = optimized_operands
          Predicate::Exclusion.new(ops.first.left, ops.map { |op| op.right }).optimize
        end

        def collapse_to_exclusion?
          all_inequality?     &&
          all_same_attribute? &&
          optimized_constants?
        end

        def all_inequality?
          optimized_operands.all? do |operand|
            operand.kind_of?(Predicate::Inequality)
          end
        end

        memoize :optimize

        module Methods
          extend Aliasable

          inheritable_alias(:& => :and)

          def and(other)
            Conjunction.new(self, other)
          end

        end # module Methods

        Connective::Methods.class_eval { include Methods }

      end # class Conjunction
    end # class Connective
  end # module Logic
end # module Veritas
