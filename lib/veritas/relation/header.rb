module Veritas
  class Relation

    # A set of attributes that correspond to values in each tuple
    class Header
      extend Aliasable
      include Enumerable, Immutable

      inheritable_alias(
        :& => :intersect,
        :| => :union,
        :- => :difference
      )

      # Initialize a Header
      #
      # @example
      #   header = Header.new(attributes)
      #
      # @param [#to_ary]
      #   optional attributes
      #
      # @return [undefined]
      #
      # @api public
      def initialize(attributes = [])
        @attributes = attributes.to_ary.map do |attribute|
          Attribute.coerce(attribute)
        end.freeze
        @names   = {}
        @indexes = {}
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
      def each(&block)
        to_ary.each(&block)
        self
      end

      # Lookup the index of an attribute in the header given a name
      #
      # @example
      #   index = header.index(:id)
      #
      # @param [Attribute, #to_ary, #to_sym] name
      #
      # @return [Integer]
      #   the offset when the name is known
      # @return [nil]
      #   nil when the attribute is unknown
      #
      # @api private
      def index(name)
        @indexes[name] ||=
          begin
            attribute = self[name]
            to_ary.index(attribute) if attribute
          end
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
        @names[name] ||=
          begin
            name = Attribute.name_from(name)
            detect { |attribute| attribute.name == name }
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
        @attributes
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
        to_set == self.class.coerce(other).to_set
      end

      # Compare the header with other header for equality
      #
      # @example
      #   header.eql?(other)  # => true or false
      #
      # @param [Header] other
      #   the other header to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        instance_of?(other.class) &&
        to_set == other.to_set
      end

      # Return the hash of the header
      #
      # @example
      #   numeric_hash = header.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        self.class.hash ^ to_ary.hash
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

      memoize :hash

    end # class Header
  end # class Relation
end # module Veritas
