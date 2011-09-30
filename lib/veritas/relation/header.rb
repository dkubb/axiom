# encoding: utf-8

module Veritas
  class Relation

    # A set of attributes that correspond to values in each tuple
    class Header
      extend Aliasable, Comparator
      include Enumerable, Immutable

      compare :to_set

      inheritable_alias(
        :& => :intersect,
        :| => :union,
        :- => :difference
      )

      # Instantiate a Header
      #
      # @example
      #   header = Header.new(attributes)
      #
      # @param [#to_ary] attributes
      #   optional attributes
      #
      # @return [undefined]
      #
      # @api public
      def self.new(attributes = [])
        attributes = coerce_attributes(attributes.to_ary)
        assert_unique_attributes(attributes)
        super
      end

      # Coerce the attributes into an Array of Attribute objects
      #
      # @param [Array<Attribute>] attributes
      #
      # @return [Array<Attribute>]
      #
      # @api private
      def self.coerce_attributes(attributes)
        attributes.map { |attribute| Attribute.coerce(attribute) }
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

      private_class_method :coerce_attributes, :assert_unique_attributes, :duplicate_attributes

      # Initialize a Header
      #
      # @example
      #   header = Header.new(attributes)
      #
      # @param [#to_ary] attributes
      #
      # @return [undefined]
      #
      # @api public
      def initialize(attributes)
        @names      = attributes.map { |attribute| attribute.name }
        @attributes = Hash[@names.zip(attributes)]
      end

      # Iterate over each attribute in the header
      #
      # @example
      #   header = Header.new(attributes)
      #   header.each { |attribute| ... }
      #
      # @yield [attribute]
      #
      # @yieldparam [Attribute] attribute
      #   each attribute in the header
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        @names.each { |name| yield @attributes.fetch(name) }
        self
      end

      # Lookup an attribute in the header given a name
      #
      # @example
      #   attribute = header[:id]
      #
      # @param [Attribute, #to_ary, #to_sym] name
      #
      # @return [Attribute]
      #   the attribute when the name is known
      # @return [nil]
      #   nil when the attribute is unknown
      #
      # @api public
      def [](name)
        @attributes[Attribute.name_from(name)]
      end

      # Return a header with only the attributes specified
      #
      # @example
      #   projected = header.project(attributes)
      #
      # @param [#map] attributes
      #   the attributes to keep in the header
      #
      # @return [Header]
      #
      # @api private
      def project(attributes)
        new(attributes.map { |attribute| self[attribute] })
      end

      # Return a header with the attributes renamed
      #
      # @example
      #   renamed = header.rename(aliases)
      #
      # @param [Aliases] aliases
      #   the old and new attribute names
      #
      # @return [Header]
      #
      # @api private
      def rename(aliases)
        new(map { |attribute| aliases[attribute] })
      end

      # Return the intersection of the header with another header
      #
      # @param [Header] other
      #
      # @return [Header]
      #
      # @api private
      def intersect(other)
        new(to_ary & other)
      end

      # Return the union of the header with another header
      #
      # @param [Header] other
      #
      # @return [Header]
      #
      # @api private
      def union(other)
        new(to_ary | other)
      end

      # Return the difference of the header with another header
      #
      # @param [Header] other
      #
      # @return [Header]
      #
      # @api private
      def difference(other)
        new(to_ary - other)
      end

      # Convert the Header into an Array
      #
      # @example
      #   array = header.to_ary
      #
      # @return [Array]
      #
      # @api private
      def to_ary
        @attributes.values_at(*@names).freeze
      end

      # Compare the header with other header for equivalency
      #
      # @example
      #   header == other  # => true or false
      #
      # @param [Header] other
      #   the other header to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def ==(other)
        cmp?(__method__, coerce(other))
      end

      # Test if there are no attributes
      #
      # @example
      #   header.empty?  # => true or false
      #
      # @return [Boolean]
      #
      # @api public
      def empty?
        @names.empty?
      end

      # Return a string representing the header
      #
      # @example
      #   header.inspect  # => "[<Attribute::Integer name: id>]"
      #
      # @return [String]
      #
      # @api public
      def inspect
        to_ary.inspect
      end

    private

      # Utility method to instantiate a Header
      #
      # @param [#to_ary] attributes
      #   the header attributes
      #
      # @return [Header]
      #
      # @api private
      def new(attributes)
        self.class.new(attributes)
      end

      # Coerce the object into a Header
      #
      # @param [Header, #to_ary]
      #   the header or attributes
      #
      # @return [Header]
      #
      # @api private
      def coerce(object)
        self.class.coerce(object)
      end

      # Coerce an Array-like object into a Header
      #
      # @param [Header, #to_ary]
      #   the header or attributes
      #
      # @return [Header]
      #
      # @api private
      def self.coerce(object)
        object.kind_of?(Header) ? object : new(object)
      end

      memoize :to_ary

    end # class Header
  end # class Relation
end # module Veritas
