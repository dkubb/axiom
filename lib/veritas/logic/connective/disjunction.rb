module Veritas
  module Logic
    class Connective
      class Disjunction < Connective
        include BinaryConnective

        def self.eval(*operands)
          operands.any?
        end

        def optimize
          left, right = optimized_operands

          if always_true?
            Proposition::True.instance
          elsif right.kind_of?(Proposition::False)
            left
          elsif left.kind_of?(Proposition::False)
            right
          elsif collapse_to_inclusion?
            new_inclusion
          else
            super
          end
        end

        def inspect
          "(#{operands.map { |operand| operand.inspect }.join(' OR ')})"
        end

      private

        def always_true?
          optimized_operands.any? do |operand|
            operand.kind_of?(Proposition::True)
          end
        end

        def new_inclusion
          ops = optimized_operands
          Predicate::Inclusion.new(ops.first.left, ops.map { |op| op.right }).optimize
        end

        def collapse_to_inclusion?
          all_equality?       &&
          all_same_attribute? &&
          optimized_constants?
        end

        def all_equality?
          optimized_operands.all? do |operand|
            operand.kind_of?(Predicate::Equality)
          end
        end

        memoize :optimize

        module Methods
          extend Aliasable

          inheritable_alias(:| => :or)

          def or(other)
            Disjunction.new(self, other)
          end

        end # module Methods

        Connective::Methods.class_eval { include Methods }

      end # class Disjunction
    end # class Connective
  end # module Logic
end # module Veritas
