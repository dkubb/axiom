# encoding: utf-8

module Veritas
  class Relation
    module Operation
      class Order

        # Abstract base class for attribute sorting
        class Direction
          include AbstractType
          include Equalizer.new(:attribute)

          # The attribute to sort on
          #
          # @return [Attribute]
          #
          # @api private
          attr_reader :attribute

          # Initialize a Direction
          #
          # @param [Attribute] attribute
          #   the attribute to sort on
          #
          # @return [undefined]
          #
          # @api private
          def initialize(attribute)
            @attribute = attribute
          end

          # Return the attribute name
          #
          # @example
          #   direction.name  # => :id
          #
          # @return [Symbol]
          #
          # @api public
          def name
            attribute.name
          end

          # Compare the left and right Tuple attribute values
          #
          # @example
          #   comparison = direction.call(left, right)
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
          # @api public
          def call(left, right)
            attribute = self.attribute
            self.class.call(attribute.call(left), attribute.call(right))
          end

          # Rename the contained attribute with the provided aliases
          #
          # @example
          #   renamed = direction.rename(aliases)
          #
          # @param [Algebra::Rename::Aliases] aliases
          #   the old and new attributes
          #
          # @return [self]
          #   if the attribute is not renamed
          # @return [Direction]
          #   if the attribute is renamed
          #
          # @api public
          def rename(aliases)
            attribute = self.attribute
            renamed   = aliases[attribute]
            renamed.equal?(attribute) ? self : self.class.new(renamed)
          end

          # Return the reverse Direction
          #
          # @example
          #   reversed = direction.reverse
          #
          # @return [Direction]
          #
          # @api public
          def reverse
            self.class.reverse.new(attribute)
          end

          # Compare the direction with other direction for equivalency
          #
          # @example
          #   direction == other  # => true or false
          #
          # @param [Direction] other
          #
          # @return [Boolean]
          #
          # @api public
          def ==(other)
            eql?(other)
          end

          # Coerce an object into a Direction
          #
          # @param [Attribute, Direction] object
          #   the object to coerce
          #
          # @return [Direction]
          #
          # @api private
          def self.coerce(object)
            object.kind_of?(Direction) ? object : new(object)
          end

        end # class Direction

        # Represent an attribute sorted ascending
        class Ascending < Direction

          # Return the reversed direction class
          #
          # @return [Class<Descending>]
          #
          # @api private
          def self.reverse
            Descending
          end

          # Compare the left and right value
          #
          # @param [Comparable] left
          # @param [Comparable] right
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
          def self.call(left, right)
            left <=> right
          end

        end # class Ascending

        # Represent an attribute sorted descending
        class Descending < Direction

          # Return the reversed direction class
          #
          # @return [Class<Ascending>]
          #
          # @api private
          def self.reverse
            Ascending
          end

          # Compare the left and right value
          #
          # @param [Comparable] left
          # @param [Comparable] right
          #
          # @return [-1]
          #   returned if the left should be sorted after the right
          #
          # @return [0]
          #   returned if the right and left are equal
          #
          # @return [1]
          #   returned if the left should be sorted before the right
          #
          # @api private
          def self.call(left, right)
            right <=> left
          end

        end # class Descending
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
