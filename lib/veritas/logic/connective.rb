module Veritas
  module Logic
    class Connective < Expression
      include AbstractClass

      module BinaryConnective
        include Immutable
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
          if duplicate_operands?
            optimize_left
          elsif redundant?
            optimize_right
          elsif optimized?
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

        def left_and_right_same_attribute?
          optimize_left.left.eql?(optimize_right.left)
        end

        def left_and_right_constants?
          left_constant? && right_constant?
        end

        def left_constant?
          !optimize_left.right.respond_to?(:call)
        end

        def right_constant?
          !optimize_right.right.respond_to?(:call)
        end

        def duplicate_operands?
          optimize_left.eql?(optimize_right)
        end

        def redundant?
          right = optimize_right
          kind_of?(right.class) && optimize_left.eql?(right.left)
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
          !optimize_left.equal?(left) || !optimize_right.equal?(right)
        end

        memoize :complement, :new_optimized_connective

      end # module BinaryConnective

      module Methods; end

    end # class Connective
  end # module Logic
end # module Veritas

require 'veritas/logic/connective/conjunction'
require 'veritas/logic/connective/disjunction'
require 'veritas/logic/connective/complement'

Veritas::Logic::Expression.class_eval { include Veritas::Logic::Connective::Methods }
