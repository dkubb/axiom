# encoding: utf-8

module Axiom
  class Relation

    # A set of attributes that correspond to values in each tuple
    class Header
      extend Aliasable
      include Enumerable
      include Equalizer.new(:to_set, :keys)

      inheritable_alias(
        :[] => :fetch,
        :&  => :intersect,
        :|  => :union,
        :-  => :difference
      )

      # The header keys
      #
      # @return [Keys]
      #
      # @api private
      attr_reader :keys

      # Convert the Header into an Array
      #
      # @example
      #   array = header.to_ary
      #
      # @return [Array]
      #
      # @api public
      attr_reader :to_ary

      # Coerce an Array-like object into a Header
      #
      # @param [Header, #to_ary] object
      #   the header or attributes
      # @param [Hash] options
      #
      # @yield [attribute]
      #
      # @yieldparam [Attribute, Array] attribute
      #
      # @return [Header]
      #
      # @api private
      def self.coerce(object, options = EMPTY_HASH)
        if object.kind_of?(self)
          object
        else
          # Find the attribute with the block if possible, then fallback
          # to the default coercion method.
          block = lambda do |attribute|
            coerce_attribute(block_given? && yield(attribute) || attribute)
          end
          new(Array(object).map(&block), options)
        end
      end

      # Instantiate a Header
      #
      # @example
      #   header = Header.new(attributes)
      #
      # @param [Array<Attribute>] attributes
      #   optional attributes
      # @param [Hash] _options
      #
      # @return [Header]
      #
      # @api public
      def self.new(attributes = EMPTY_ARRAY, *)
        assert_unique_names(attributes.map(&:name))
        super
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
          fail DuplicateNameError, "duplicate names: #{duplicates}"
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

      private_class_method :coerce_attribute, :assert_unique_names, :duplicate_names

      # Initialize a Header
      #
      # @example
      #   header = Header.new(attributes, keys: [[:id]])
      #
      # @param [Array] attributes
      #
      # @param [Hash] options
      #
      # @return [undefined]
      #
      # @api public
      def initialize(attributes, options = EMPTY_HASH)
        @to_ary        = freeze_object(attributes)
        @attribute_for = Hash[@to_ary.map(&:name).zip(@to_ary)]
        @keys          = coerce_keys(options.fetch(:keys, EMPTY_ARRAY))
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
      def fetch(name)
        @attribute_for.fetch(Attribute.name_from(name)) do |attribute_name|
          fail(
            UnknownAttributeError,
            "the attribute #{attribute_name} is unknown"
          )
        end
      end

      # Return a header with only the attributes specified
      #
      # The unique keys intersected with the attributes become the new keys
      # because a projection strengthens key constraints.
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
        coerce(attributes, keys: keys.project(attributes))
      end

      # Return a header with the new attributes added
      #
      # The original keys from the header are reused because
      # an extension does not affect key constraints.
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
        new(to_ary + coerce(attributes), keys: keys)
      end

      # Return a header with the attributes renamed
      #
      # The attributes in the original keys are renamed, but
      # a rename does not otherwise affect the key constraints.
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
        aliases = Algebra::Rename::Aliases.coerce(self, aliases)
        new(map(&aliases.method(:[])), keys: keys.rename(aliases))
      end

      # Return the intersection of the header with another header
      #
      # The unique keys from the headers become the new keys because
      # an intersection strengthens key constraints.
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
        other      = coerce(other)
        attributes = to_ary & other
        new(attributes, keys: (keys | other.keys).project(attributes))
      end

      # Return the union of the header with another header
      #
      # The common keys from the headers become the new keys because
      # a union weakens key constraints.
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
        other = coerce(other)
        new(to_ary | other, keys: keys & other.keys)
      end

      # Return the difference of the header with another header
      #
      # The original keys from the header are reused because
      # a difference does not affect key constraints.
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
        other = coerce(other)
        new(to_ary - other, keys: keys - other.keys)
      end

      # Evaluate a block within the context of the header
      #
      # @yield [context]
      #
      # @yieldparam [Evaluator::Context] context
      #
      # @yieldreturn [Evaluator::Context]
      #
      # @return [Header]
      #
      # @api private
      def context(&block)
        Evaluator::Context.new(self, &block)
      end

      # The number of attributes
      #
      # @return [Integer]
      #
      # @api public
      def size
        to_ary.size
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

      # Coerce the keys into an Array of Headers
      #
      # @return [Array]
      #
      # @return [Array<Header>]
      #
      # @api private
      def coerce_keys(keys)
        Keys.coerce(keys) { |attributes| coerce(attributes) }
      end

      # Coerce the object into a Header
      #
      # @param [Array] args
      #
      # @return [Header]
      #
      # @api private
      def coerce(*args)
        self.class.coerce(*args, &@attribute_for.method(:[]))
      end

      # Represent an empty set of attributes
      EMPTY = new

    end # class Header
  end # class Relation
end # module Axiom
