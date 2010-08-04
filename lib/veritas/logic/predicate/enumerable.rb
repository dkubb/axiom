module Veritas
  module Logic
    class Predicate
      module Enumerable

        def initialize(left, right)
          super(left, right.nil? ? right : right.dup.freeze)
        end

        def optimize
          if includes_nothing?
            new_optimized_none
          elsif right_one?
            new_optimized_one
          elsif !optimized?
            new_optimized_enumerable
          else
            super
          end
        end

      private

        def optimize_right
          right = self.right

          if right.respond_to?(:to_inclusive)
            optimize_right_range
          elsif right.respond_to?(:select)
            optimize_right_enumerable
          else
            right
          end
        end

        def optimize_right_range
          right.to_inclusive if right.overlaps?(left.range)
        end

        def optimize_right_enumerable
          right = self.right
          # TODO: consider a data structure that makes matching, sorting
          # uniquing of large enumerables more efficient.
          enumerable = right.select { |value| left.valid_value?(value) }
          enumerable.sort!
          enumerable.uniq!
          right.eql?(enumerable) ? right : enumerable
        end

        def optimized?
          optimize_right.equal?(right)
        end

        def new_optimized_enumerable
          self.class.new(left, optimize_right)
        end

        def includes_nothing?
          right_nil? || right_empty?
        end

        def right_nil?
          optimize_right.nil?
        end

        def right_empty?
          optimize_right.each { return false }
          true
        end

        def right_one?
          index = 0
          optimize_right.detect { (index += 1) != 1 }
          index == 1
        end

      end # module Enumerable
    end # class Predicate
  end # module Logic
end # module Veritas
