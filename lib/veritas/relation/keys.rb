# encoding: utf-8

module Veritas
  class Relation

    # A set of keys in a Header
    class Keys
      extend Aliasable
      include Enumerable
      include Equalizer.new(:to_set)

      inheritable_alias(
        :& => :intersect,
        :| => :union,
        :- => :difference
      )

      # Coerce an Array-like object into Keys
      #
      # @param [Keys, #to_ary] object
      #
      # @yield [attributes]
      #
      # @yieldparam [Header, Array] attributes
      #   the attributes in each key
      #
      # @return [Keys]
      #
      # @api private
      def self.coerce(object, &block)
        if object.kind_of?(self)
          object
        else
          block ||= lambda { |attributes| coerce_attributes(attributes) }
          new(object.map(&block))
        end
      end

      # Instantiate Keys
      #
      # @example
      #   keys = Keys.new(keys)
      #
      # @param [Array<Header>] keys
      #
      # @return [Keys]
      #
      # @api public
      def self.new(keys = EMPTY_ARRAY)
        assert_irreducible_keys(keys.map(&:to_set))
        super
      end

      # Coerce the attributes into a Header
      #
      # @param [Object] attributes
      #
      # @return [Header]
      #
      # @api private
      def self.coerce_attributes(attributes)
        Header.coerce(attributes)
      end

      # Assert the keys are irreducible
      #
      # In a relation a candidate key must be irreducible, which means that
      # there can't exist another key that is a proper subset of it. If this
      # occurs, we should raise an exception because it means there is a
      # specification error in the system.
      #
      # @param [Array<Set>] keys
      #
      # @return [undefined]
      #
      # @raise [ReducibleKeyError]
      #   raised if a key can be reduced
      #
      # @api private
      def self.assert_irreducible_keys(keys)
        reducible_keys = reducible_keys(keys)
        if reducible_keys
          raise ReducibleKeyError, "reducible keys: #{reducible_keys.inspect}"
        end
      end

      # The keys that can be reduced
      #
      # @param [Array<Header>] keys
      #
      # @return [Boolean]
      #
      # @api private
      def self.reducible_keys(keys)
        keys.permutation(2).select { |key, other| key.proper_superset?(other) }.
          transpose.first
      end

      private_class_method :coerce_attributes, :assert_irreducible_keys, :reducible_keys

      # Initialize Keys
      #
      # @example
      #   keys = Keys.new([ [ :id ] ])
      #
      # @param [Array<Header>] keys
      #
      # @return [undefined]
      #
      # @api public
      def initialize(keys)
        @keys = freeze_object(keys)
      end

      # Iterate over each key in the Keys
      #
      # @example
      #   keys = Keys.new(keys)
      #   keys.each { |key| ... }
      #
      # @yield [key]
      #
      # @yieldparam [Header] key
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        to_ary.each { |key| yield key }
        self
      end

      # Return keys with only the attributes specified
      #
      # When the attributes do not match any attributes in an existing
      # key, then the key should be removed because it means the attributes
      # it applied against no longer exist in the new header.
      #
      # @example
      #   projected = keys.project(attributes)
      #
      # @param [#map] attributes
      #   the attributes to keep in the keys
      #
      # @return [Keys]
      #
      # @api public
      def project(attributes)
        new(map { |key| key & attributes }.delete_if(&:empty?))
      end

      # Return keys with the new attributes added
      #
      # @example
      #   extended = keys.extend(attributes)
      #
      # @param [#to_ary] attributes
      #   the attributes to add to the keys
      #
      # @return [Keys]
      #
      # @api public
      def extend(attributes)
        if empty?
          coerce(attributes)
        else
          new(map { |key| key | attributes })
        end
      end

      # Return keys with the attributes renamed
      #
      # @example
      #   renamed = keys.rename(aliases)
      #
      # @param [Aliases] aliases
      #   the old and new attribute names
      #
      # @return [Keys]
      #
      # @api public
      def rename(aliases)
        new(map { |key| key.rename(aliases) })
      end

      # Return the intersection of the keys with other keys
      #
      # @example
      #   intersection = keys.intersect(other)
      #
      # @param [Keys] other
      #
      # @return [Keys]
      #
      # @api public
      def intersect(other)
        new(to_ary & other)
      end

      # Return the union of the keys with other keys
      #
      # @example
      #   union = keys.union(other)
      #
      # @param [Keys] other
      #
      # @return [Keys]
      #
      # @api public
      def union(other)
        new(to_ary | other)
      end

      # Return the difference of the keys with other keys
      #
      # @example
      #   difference = keys.difference(other)
      #
      # @param [Keys] other
      #
      # @return [Keys]
      #
      # @api public
      def difference(other)
        new(to_ary - other)
      end

      # Convert the Keys into an Array
      #
      # @example
      #   array = keys.to_ary
      #
      # @return [Array]
      #
      # @api public
      def to_ary
        @keys
      end

      # Test if there are no keys
      #
      # @example
      #   keys.empty?  # => true or false
      #
      # @return [Boolean]
      #
      # @api public
      def empty?
        to_ary.empty?
      end

    private

      # Utility method to instantiate Keys
      #
      # @param [Array] keys
      #
      # @return [Keys]
      #
      # @api private
      def new(keys)
        to_ary == keys ? self : self.class.new(keys)
      end

      # Coerce the object into Keys
      #
      # @param [Keys, #to_ary] object
      #
      # @return [Keys]
      #
      # @api private
      def coerce(object)
        self.class.coerce(object)
      end

      # Represent an empty set of keys
      EMPTY = new

    end # class Keys
  end # class Relation
end # module Veritas
