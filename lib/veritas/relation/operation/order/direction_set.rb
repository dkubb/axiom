# encoding: utf-8

module Veritas
  class Relation
    module Operation
      class Order

        # A class that represents a tuple sort order for a set of attributes
        class DirectionSet
          extend Aliasable
          include Enumerable, Immutable

          inheritable_alias(:| => :union)

          # Instantiate a DirectionSet
          #
          # @example
          #   directions = DirectionSet.new(directions)
          #
          # @param [#to_ary] directions
          #   optional attributes
          #
          # @return [undefined]
          #
          # @api public
          def self.new(directions)
            directions = coerce_directions(directions)
            assert_unique_attributes(directions.map { |direction| direction.attribute })
            super
          end

          # Coerce the attributes into an Array of Direction objects
          #
          # @param [Array<Direction>] attributes
          #
          # @return [Array<Direction>]
          #
          # @api private
          def self.coerce_directions(directions)
            Array(directions).map { |direction| Ascending.coerce(direction) }
          end

          # Assert the attributes are unique
          #
          # @param [Array<Attribute>] attributes
          #
          # @return [undefined]
          #
          # @raise [DuplicateAttributeError]
          #   raised if the attributes are not unique
          #
          # @api private
          def self.assert_unique_attributes(attributes)
            duplicates = duplicate_attributes(attributes)
            if duplicates
              raise DuplicateAttributeError, "duplicate attributes: #{duplicates.join(', ')}"
            end
          end

          # Returns the duplicate attribute names, if any
          #
          # @param [Array<Attribute>] attributes
          #
          # @return [Array<Symbol>]
          #   returns an array of duplicate attributes
          #
          # @return [nil]
          #   returns nil if there are no duplicate attributes
          #
          # @api private
          def self.duplicate_attributes(attributes)
            names = attributes.map { |attribute| attribute.name }
            names.select! { |name| names.count(name) > 1 }
            names.uniq!
          end

          private_class_method :coerce_directions, :assert_unique_attributes, :duplicate_attributes

          # Initialize a DirectionSet
          #
          # @param [Array<Direction>] directions
          #   the directions to sort with
          #
          # @return [undefined]
          #
          # @api private
          def initialize(directions)
            @directions = directions
          end

          EMPTY = new([])

          # Return a direction set with only the attributes specified
          #
          # @example
          #   projected = directions.project([ attribute ])
          #
          # @param [Array<Attribute>] attributes
          #   the attributes to keep in the direction set
          #
          # @return [DirectionSet]
          #
          # @api public
          def project(attributes)
            new select { |direction|
              attributes.include?(direction.attribute)
            }
          end

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
            new(map { |direction| direction.reverse })
          end

          # Iterate over each direction in the set
          #
          # @example
          #   directions = DirectionSet.new(directions)
          #   directions.each { |direction| ... }
          #
          # @yield [direction]
          #
          # @yieldparam [Direction] direction
          #   each direction in the set
          #
          # @return [self]
          #
          # @api public
          def each
            return to_enum unless block_given?
            to_ary.each { |tuple| yield tuple }
            self
          end

          # Return the directions as an Array
          #
          # @return [Array]
          #
          # @api private
          def to_ary
            @directions
          end

          # Union the directions with another set of directions
          #
          # @example
          #   union = directions.union(other)
          #
          # @param [DirectionSet] other
          #   the directions to union with
          #
          # @return [DirectionSet]
          #
          # @api public
          def union(other)
            new(to_ary | other.to_ary)
          end

          # Return each attribute in an Array
          #
          # @return [Array]
          #
          # @api private
          def attributes
            map { |direction| direction.attribute }
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
            tuples.sort { |left, right| cmp_tuples(left, right) }
          end

          # Compare the directions with other directions for equivalency
          #
          # @example
          #   directions == other  # => true or false
          #
          # @param [DirectionSet] other
          #   the other directions to compare with
          #
          # @return [Boolean]
          #
          # @api public
          def ==(other)
            other = self.class.coerce(other)
            to_ary == other.to_ary
          end

          # Compare the directions with other directions for equality
          #
          # @example
          #   directions.eql?(other)  # => true or false
          #
          # @param [DirectionSet] other
          #   the other directions to compare with
          #
          # @return [Boolean]
          #
          # @api public
          def eql?(other)
            instance_of?(other.class) &&
            to_ary.eql?(other.to_ary)
          end

          # Return the hash of the aliases
          #
          # @example
          #   hash = directions.hash
          #
          # @return [Fixnum]
          #
          # @api public
          def hash
            self.class.hash ^ to_ary.hash
          end

          # Test if there are no directions
          #
          # @example
          #   directions.empty?  # => true or false
          #
          # @return [Boolean]
          #
          # @api public
          def empty?
            @directions.empty?
          end

        private

          # Utility method for initializing a set of directions
          #
          # @param [Array<Direction>] directions
          #
          # @return [DirectionSet]
          #
          # @api private
          def new(directions)
            self.class.new(directions)
          end

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
              break cmp if cmp.nonzero?
              direction.call(left, right)
            end
          end

          # Coerce directions into a DirectionSet
          #
          # @param [DirectionSet, Array<Direction, Attribute>]
          #
          # @return [DirectionSet]
          #
          # @api private
          def self.coerce(object)
            object.kind_of?(DirectionSet) ? object : new(object)
          end

          memoize :hash, :reverse

        end # class DirectionSet
      end # class Order
    end # module Operation
  end # class Relation
end # module Veritas
