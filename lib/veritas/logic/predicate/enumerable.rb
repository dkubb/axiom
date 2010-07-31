module Veritas
  module Logic
    class Predicate
      module Enumerable

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
          inclusive = right.to_inclusive
          inclusive if inclusive.overlaps?(left_min..left_max)
        end

        def optimize_right_enumerable
          # TODO: consider a data structure that makes matching, sorting
          # uniquing of large enumerables more efficient.
          enumerable = right.select { |value| left.valid_value?(value) }
          enumerable.sort!
          enumerable.uniq!
          enumerable
        end

        def optimized?
          optimize_right.eql?(right)
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
