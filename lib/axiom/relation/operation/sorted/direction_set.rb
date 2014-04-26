# encoding: utf-8

module Axiom
  class Relation
    module Operation
      class Sorted

        # A class that represents a tuple sort order for a set of attributes
        class DirectionSet < Header
          include AST::Sexp
          include Equalizer.new(:to_ary)

          # Coerce the attribute into a Direction
          #
          # @param [Object] attribute
          #
          # @return [Direction]
          #
          # @api private
          def self.coerce_attribute(attribute)
            Ascending.coerce(attribute)
          end

          private_class_method :coerce_attribute

          # Rename the contained attributes with the provided aliases
          #
          # @example
          #   renamed = directions.rename(aliases)
          #
          # @param [Algebra::Rename::Aliases] aliases
          #   the old and new attributes
          #
          # @return [DirectionSet]
          #
          # @api public
          def rename(aliases)
            new(map { |direction| direction.rename(aliases) })
          end

          # Reverse the directions for each attribute
          #
          # @example
          #   reversed = directions.reverse
          #
          # @return [DirectionSet]
          #
          # @api public
          def reverse
            new(map(&:reverse))
          end

          # Return each attribute in an Array
          #
          # @return [Array]
          #
          # @api private
          def attributes
            map(&:attribute)
          end

          # Sort the supplied tuples in the correct direction
          #
          # @param [Array] tuples
          #   the list of tuples to sort
          #
          # @return [Array]
          #   the sorted tuples
          #
          # @api private
          def sort_tuples(tuples)
            tuples.to_a.sort { |left, right| cmp_tuples(left, right) }
          end

          def to_ast
            s(:directions, *map(&:to_ast))
          end

        private

          # Compare the attributes for each Tuple
          #
          # @param [Tuple] left
          # @param [Tuple] right
          #
          # @return [-1]
          #   returned if the left should be sorted before the right
          #
          # @return [0]
          #   returned if the left and right are equal
          #
          # @return [1]
          #   returned if the left should be sorted after the right
          #
          # @api private
          def cmp_tuples(left, right)
            reduce(0) do |cmp, direction|
              return cmp if cmp.nonzero?
              direction.call(left, right)
            end
          end

          memoize :reverse, :attributes

          # Represent an empty set of directions
          EMPTY = new

        end # class DirectionSet
      end # class Sorted
    end # module Operation
  end # class Relation
end # module Axiom
