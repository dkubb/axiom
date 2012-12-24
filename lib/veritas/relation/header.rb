# encoding: utf-8

module Veritas
  class Relation

    # A set of attributes that correspond to values in each tuple
    class Header
      extend Aliasable
      include Enumerable
      include Equalizer.new(:to_set)

      inheritable_alias(
        :[] => :call,
        :&  => :intersect,
        :|  => :union,
        :-  => :difference
      )

      # Instantiate a Header
      #
      # @example
      #   header = Header.new(attributes)
      #
      # @param [#to_ary] attributes
      #   optional attributes
      #
      # @return [Header]
      #
      # @api public
      def self.new(attributes = nil)
        attributes = coerce_attributes(attributes)
        assert_unique_names(attributes.map { |attribute| attribute.name })
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
        Array(attributes).map { |attribute| coerce_attribute(attribute) }
      end

      # Coerce the attribute into an Attribute
      #
      # @param [Object] attribute
      #
      # @return [Attribute]
      #
      # @api private
      def self.coerce_attribute(attribute)
        Attribute.coerce(attribute)
      end

      # Assert the names are unique
      #
      # @param [Array<Symbol>] names
      #
      # @return [undefined]
      #
      # @raise [DuplicateNameError]
      #   raised if the names are not unique
      #
      # @api private
      def self.assert_unique_names(names)
        duplicates = duplicate_names(names)
        if duplicates
          raise DuplicateNameError, "duplicate names: #{duplicates.join(', ')}"
        end
      end

      # Returns the duplicate names, if any
      #
      # @param [Array<Symbol>] names
      #
      # @return [Array<Symbol>]
      #   returns an array of duplicate names
      #
      # @return [nil]
      #   returns nil if there are no duplicate names
      #
      # @api private
      def self.duplicate_names(names)
        names.select { |name| names.count(name) > 1 }.uniq!
      end

      private_class_method :coerce_attributes, :coerce_attribute, :assert_unique_names, :duplicate_names

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
        @attributes    = freeze_object(attributes.to_ary)
        @attribute_for = Hash[@attributes.map { |attribute| attribute.name }.zip(@attributes)]
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
        to_ary.each { |attribute| yield attribute }
        self
      end

      # Lookup an attribute in the header given a name
      #
      # @example
      #   attribute = header.call(:id)
      #
      # @param [Attribute, #to_ary, #to_sym] name
      #
      # @return [Attribute]
      #   the attribute when the name is known
      #
      # @api public
      def call(name)
        @attribute_for.fetch(Attribute.name_from(name)) do |attribute_name|
          raise UnknownAttributeError,
            "the attribute #{attribute_name} is unknown"
        end
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
      # @api public
      def project(attributes)
        new(attributes.map { |attribute| self[attribute] })
      end

      # Return a header with the new attributes added
      #
      # @example
      #   extended = header.extend(attributes)
      #
      # @param [#to_ary] attributes
      #   the attributes to add to the header
      #
      # @return [Header]
      #
      # @api public
      def extend(attributes)
        new(@attributes + attributes.to_ary)
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
      # @api public
      def rename(aliases)
        new(map { |attribute| aliases[attribute] })
      end

      # Return the intersection of the header with another header
      #
      # @example
      #   intersection = header.intersect(other)
      #
      # @param [Header] other
      #
      # @return [Header]
      #
      # @api public
      def intersect(other)
        new(to_ary & other)
      end

      # Return the union of the header with another header
      #
      # @example
      #   union = header.union(other)
      #
      # @param [Header] other
      #
      # @return [Header]
      #
      # @api public
      def union(other)
        new(to_ary | other)
      end

      # Return the difference of the header with another header
      #
      # @example
      #   difference = header.difference(other)
      #
      # @param [Header] other
      #
      # @return [Header]
      #
      # @api public
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
      # @api public
      def to_ary
        @attributes
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
        to_ary.empty?
      end

    private

      # Utility method to instantiate a Header
      #
      # @param [Array] args
      #
      # @return [Header]
      #
      # @api private
      def new(*args)
        self.class.new(*args)
      end

      # Coerce the object into a Header
      #
      # @param [Header, #to_ary] object
      #   the header or attributes
      #
      # @return [Header]
      #
      # @api private
      def coerce(object)
        self.class.coerce(object)
      end

      # Coerce the object into a Header
      #
      # @param [Header, #to_ary] object
      #   the header or attributes
      #
      # @return [Header]
      #
      # @api private
      def self.coerce(object)
        object.kind_of?(self) ? object : new(object)
      end

      # Represent an empty set of attributes
      EMPTY = new

    end # class Header
  end # class Relation
end # module Veritas
