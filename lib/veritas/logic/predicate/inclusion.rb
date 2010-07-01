module Veritas
  module Logic
    class Predicate
      class Inclusion < Predicate
        def self.eval(left, right)
          right.include?(left)
        end

        def optimize
          if not_comparable? || includes_nothing?
            Proposition::False.instance
          elsif right_one?
            Equality.new(left, optimize_right.first)
          elsif optimized?
            new_optimized_inclusion
          else
            super
          end
        end

        def inspect
          "#{left.inspect} IN(#{right.inspect})"
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
          !optimize_right.eql?(right)
        end

        def new_optimized_inclusion
          self.class.new(left, optimize_right)
        end

        def not_comparable?
          right.kind_of?(Range) && !left.kind_of?(Attribute::Comparable)
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

        memoize :optimize

        module Methods
          def include(other)
            Inclusion.new(self, other)
          end

        end # module Methods
      end # class Inclusion
    end # class Predicate
  end # module Logic
end # module Veritas
