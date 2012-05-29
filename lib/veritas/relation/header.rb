# encoding: utf-8

module Veritas
  class Relation

    # A set of attributes that correspond to values in each tuple
    class Header
      extend Aliasable
      include Enumerable, Immutable
      include Equalizer.new(self, :to_set)

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
        @attributes    = Immutable.freeze_object(attributes.to_ary)
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
      # @param [Array] *args
      #
      # @return [Header]
      #
      # @api private
      def new(*args)
        self.class.new(*args)
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
        object.kind_of?(self) ? object : new(object)
      end

    end # class Header
  end # class Relation
end # module Veritas
