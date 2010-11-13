module Veritas
  module Algebra
    class Rename

      # Aliases that map old attributes to new renamed attributes
      class Aliases
        extend Aliasable
        include Immutable, Enumerable

        inheritable_alias(:| => :union)

        # Initialize rename aliases
        #
        # @param [#to_hash] aliases
        #   the old and new attributes
        #
        # @return [undefined]
        #
        # @api public
        def initialize(aliases)
          @aliases = Immutable.freeze_object(aliases.to_hash)
        end

        # Lookup the new attribute given the old attribute
        #
        # @example
        #   new_attribute = aliases[old_attribute]
        #
        # @param [Attribute] attribute
        #   the old attribute
        #
        # @return [Attribute]
        #
        # @api public
        def [](attribute)
          @aliases.fetch(attribute, attribute)
        end

        # Union the aliases with another set of aliases
        #
        # @example
        #   new_aliases = aliases.union(other)
        #
        # @param [Aliases] other
        #   the aliases to union with
        #
        # @return [Aliases]
        #
        # @api public
        def union(other)
          other_aliases = other.to_hash.dup
          inverted      = other_aliases.invert

          each do |old_attribute, new_attribute|
            old_attribute = inverted.fetch(old_attribute, old_attribute)

            if old_attribute.eql?(new_attribute)
              other_aliases.delete(new_attribute)
            else
              other_aliases[old_attribute] = new_attribute
            end
          end

          self.class.new(other_aliases)
        end

        # Iterate over each old and new attribute
        #
        # @example
        #   aliases = Aliases.new(old => new)
        #   aliases.each { |old, new| ... }
        #
        # @yield [old, new]
        #
        # @yieldparam [Attribute] old
        #   the old attribute
        # @yieldparam [Attribute] new
        #   the new attribute
        #
        # @return [self]
        #
        # @api public
        def each(&block)
          @aliases.each(&block)
          self
        end

        # Test if there are no aliases
        #
        # @example
        #   aliases.empty?  # => true or false
        #
        # @return [Boolean]
        #
        # @api public
        def empty?
          @aliases.empty?
        end

        # Compare the aliases with other aliases for equivalency
        #
        # @example
        #   aliases == other  # => true or false
        #
        # @param [Aliases] other
        #   the other aliases to compare with
        #
        # @return [Boolean]
        #
        # @api public
        def ==(other)
          (kind_of?(other.class) || other.kind_of?(self.class)) &&
          to_hash == other.to_hash
        end

        # Compare the aliases with other aliases for equality
        #
        # @example
        #   aliases.eql?(other)  # => true or false
        #
        # @param [Aliases] other
        #   the other aliases to compare with
        #
        # @return [Boolean]
        #
        # @api public
        def eql?(other)
          instance_of?(other.class) &&
          to_hash.eql?(other.to_hash)
        end

        # Return the hash of the aliases
        #
        # @example
        #   numeric_hash = aliases.hash
        #
        # @return [Integer]
        #
        # @api public
        def hash
          @aliases.hash
        end

        # Convert the aliases to a Hash
        #
        # @example
        #   hash = aliases.to_hash
        #
        # @return [Hash]
        #
        # @api public
        def to_hash
          @aliases
        end

        # Coerce a Hash of old and new attributes into Aliases
        #
        # @param [Header] attributes
        #   the header containing the old attributes
        # @param [Aliases, #map] aliases
        #   the aliases to coerce
        #
        # @return [Aliases]
        #
        # @api private
        def self.coerce(attributes, aliases)
          return aliases if aliases.kind_of?(Aliases)
          renames = aliases.map do |old_attr, new_attr|
            coerce_alias_pair(attributes, old_attr, new_attr)
          end
          new(Hash[renames].freeze)
        end

        # Coerce old and new attributes into Attribute objects
        #
        # @param [Header] attributes
        #   the header containing the old attributes
        # @param [Symbol, Attribute] old_attr
        #   the old attribute name or Attribute object
        # @param [Symbol, Attribute] new_attr
        #   the new attribute name or Attribute object
        #
        # @return [Array(Attribute, Attribute)]
        #
        # @api private
        def self.coerce_alias_pair(attributes, old_attr, new_attr)
          old_attr = attributes[old_attr]      if old_attr.kind_of?(Symbol)
          new_attr = old_attr.rename(new_attr) if new_attr.kind_of?(Symbol)
          [ old_attr, new_attr ]
        end

        private_class_method :coerce_alias_pair

        memoize :hash

      end # class Aliases
    end # class Rename
  end # module Algebra
end # module Veritas
