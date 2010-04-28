module Veritas
  module Logic
    class Predicate
      class Inclusion < Predicate
        def self.eval(left, right)
          right.include?(left)
        end

        def optimize
          left           = self.left
          false_instance = Proposition::False.instance

          return false_instance if right.kind_of?(Range) && !left.kind_of?(Attribute::Comparable)

          right = optimize_right

          if right.nil? || right.respond_to?(:empty?) && right.empty?
            return false_instance
          elsif right != self.right
            return self.class.new(left, right)
          end

          super
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
          right = self.right.to_inclusive
          return [] if empty_right?           ||
                       left_max < right.first ||
                       left_min > right.last
          right
        end

        def optimize_right_enumerable
          right.select { |value| left.valid_value?(value) }
        end

        def empty_right?
          right.each { return false }
          true
        end

      end # class Inclusion
    end # class Predicate
  end # module Logic
end # module Veritas
