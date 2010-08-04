module Veritas
  module Logic
    class Connective < Expression
      module Binary
        include Operation::Binary

        def call(tuple)
          self.class.eval(left.call(tuple), right.call(tuple))
        end

        def project(attributes)
          left  = self.left.project(attributes)
          right = self.right.project(attributes)

          if left.nil?
            right
          elsif right.nil?
            left
          else
            super
          end
        end

        def rename(aliases)
          left          = self.left
          right         = self.right
          renamed_left  = left.rename(aliases)
          renamed_right = right.rename(aliases)

          if left.equal?(renamed_left) && right.equal?(renamed_right)
            self
          else
            self.class.new(renamed_left, renamed_right)
          end
        end

        def complement
          Complement.new(self)
        end

        def optimize
          if duplicate_optimized_operands? || redundant_left?
            optimize_left
          elsif redundant_right?
            optimize_right
          elsif always_true?
            Proposition::True.instance
          elsif always_false?
            Proposition::False.instance
          elsif !optimized?
            new_optimized_connective
          else
            super
          end
        end

        def eql?(other)
          instance_of?(other.class) &&
          left.eql?(other.left)     &&
          right.eql?(other.right)
        end

        def hash
          left.hash ^ right.hash
        end

      private

        def equality_with_same_attributes?
          equality?        &&
          same_attributes? &&
          constants?
        end

        def inequality_with_same_attributes?
          inequality?      &&
          same_attributes? &&
          constants?
        end

        def complementary_predicates?
          optimize_left.complement.eql?(optimize_right)
        end

        def equality?
          optimize_left.kind_of?(Predicate::Equality) &&
          optimize_right.kind_of?(Predicate::Equality)
        end

        def inequality?
          optimize_left.kind_of?(Predicate::Inequality) &&
          optimize_right.kind_of?(Predicate::Inequality)
        end

        def same_attributes?
          optimize_left.left.eql?(optimize_right.left)
        end

        def constants?
          left_constant? && right_constant?
        end

        def left_constant?
          !optimize_left.right.respond_to?(:call)
        end

        def right_constant?
          !optimize_right.right.respond_to?(:call)
        end

        def duplicate_optimized_operands?
          optimize_left.eql?(optimize_right)
        end

        def redundant_left?
          left = optimize_left
          kind_of?(left.class) && optimize_right.eql?(left.right)
        end

        def redundant_right?
          right = optimize_right
          kind_of?(right.class) && optimize_left.eql?(right.left)
        end

        def always_true?
          false
        end

        def always_false?
          false
        end

        def optimize_left
          left.optimize
        end

        def optimize_right
          right.optimize
        end

        def new_optimized_connective
          self.class.new(optimize_left, optimize_right)
        end

        def optimized?
          optimize_left.equal?(left) && optimize_right.equal?(right)
        end

        memoize :complement, :new_optimized_connective

      end # module Binary
    end # class Connective
  end # module Logic
end # module Veritas
