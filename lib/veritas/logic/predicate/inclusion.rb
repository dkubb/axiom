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
          @optimize_right ||=
            begin
              right = self.right

              if right.respond_to?(:to_inclusive)
                optimize_right_range
              elsif right.respond_to?(:select)
                optimize_right_enumerable
              else
                right
              end
            end
        end

        def optimize_right_range
          right = self.right.to_inclusive
          first = right.first
          return [] if !right.include?(first) ||
                       left_max < first       ||
                       left_min > right.last
          right
        end

        def optimize_right_enumerable
          right.select { |value| left.valid_value?(value) }
        end

        def optimized?
          !optimize_right.equal?(right)
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

        module Methods
          def in(other)
            Inclusion.new(self, other)
          end

        end # module Methods
      end # class Inclusion
    end # class Predicate
  end # module Logic
end # module Veritas
