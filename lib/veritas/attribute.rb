# encoding: utf-8

module Veritas

  # Abstract base class representing a type of data in a relation tuple
  class Attribute
    extend Aliasable
    include AbstractClass, Immutable, ::Comparable, Visitable

    # The attribute name
    #
    # @return [Symbol]
    #
    # @api private
    attr_reader :name

    # The attribute options
    #
    # @return [Hash]
    #
    # @api private
    attr_reader :options

    # Initialize an Attribute
    #
    # @param [#to_sym] name
    #   the attribute name
    # @param [#to_hash] options
    #   the options for the attribute
    # @option options [Boolean] :required (true)
    #   if true, then the value cannot be nil
    #
    # @return [undefined]
    #
    # @api private
    def initialize(name, options = {})
      @name     = name.to_sym
      @options  = Immutable.freeze_object(options.to_hash)
      @required = @options.fetch(:required, true)
    end

    # Extract the value corresponding to this attribute from a tuple
    #
    # @example
    #   value = attribute.call(tuple)
    #
    # @param [Tuple] tuple
    #   the tuple to extract the value from
    #
    # @return [Object]
    #
    # @api public
    def call(tuple)
      tuple[self]
    end

    # Rename an attribute
    #
    # @example
    #   new_attribute = attribute.rename(new_name)
    #
    # @param [Symbol] new_name
    #   the new name to rename the attribute to
    #
    # @return [Attribute]
    #
    # @todo Make this have the same API as functions
    #
    # @api public
    def rename(new_name)
      name.equal?(new_name) ? self : self.class.new(new_name, options)
    end

    # Return the type returned from #call
    #
    # @return [Class<Attribute>]
    #
    # @api public
    def type
      self.class
    end

    # Test if the attribute is required
    #
    # @example
    #   attribute.required?  # => true or false
    #
    # @return [Boolean]
    #
    # @api public
    def required?
      @required
    end

    # Test if a value is the correct primitive type
    #
    # @example
    #   attribute.valid_primitive?(value)  # => true or false
    #
    # @param [Object] value
    #   the value to test
    #
    # @return [Boolean]
    #
    # @api public
    def valid_primitive?(value)
      value.kind_of?(self.class.primitive)
    end

    # Test if the value matches the attribute constraints
    #
    # @example
    #   attribute.valid_value?(value)  # => true or false
    #
    # @param [Object] value
    #   the value to test
    #
    # @return [Boolean]
    #
    # @api public
    def valid_value?(value)
      valid_or_optional?(value) { valid_primitive?(value) }
    end

    # Test if the attribute can be joined with the other attribute
    #
    # @example
    #   attribute.joinable?(other)  # => true or false
    #
    # @param [Attribute] other
    #   the other attribute to test
    #
    # @return [Boolean]
    #
    # @api public
    def joinable?(other)
      kind_of?(other.class) || other.kind_of?(self.class)
    end

    # Compare the attribute with other attribute for equivalency
    #
    # @example
    #   attribute == other  # => true or false
    #
    # @param [Attribute] other
    #   the other attribute to compare with
    #
    # @return [Boolean]
    #
    # @api public
    def ==(other)
      other = Attribute.coerce(other)
      name.equal?(other.name) &&
      options == other.options
    end

    # Compare the attribute with other attribute for equality
    #
    # @example
    #   attribute.eql?(other)  # => true or false
    #
    # @param [Attribute] other
    #   the other attribute to compare with
    #
    # @return [Boolean]
    #
    # @api public
    def eql?(other)
      instance_of?(other.class) &&
      name.equal?(other.name)   &&
      options.eql?(other.options)
    end

    # Return the hash of the attribute
    #
    # @example
    #   hash = attribute.hash
    #
    # @return [Fixnum]
    #
    # @api public
    def hash
      self.class.hash ^ name.hash ^ options.hash
    end

    # Return a string representing the attribute
    #
    # @example
    #   attribute.inspect  # => "<Attribute::Integer name: id>"
    #
    # @return [String]
    #
    # @api public
    def inspect
      "<#{self.class.name.sub(/\AVeritas::/, '')} name: #{name}>"
    end

    # Coerce an object into an Attribute
    #
    # @param [Attribute, #to_ary, #to_sym] object
    #   the object to coerce
    #
    # @return [Attribute]
    #
    # @api private
    def self.coerce(object)
      if object.kind_of?(Attribute)
        object
      else
        name, type = object
        klass = equal?(Attribute) ? Object : self
        klass = const_get(type.name) if type
        klass.new(name)
      end
    end

    # Extract the attribute name from the object
    #
    # @param [#name, #to_ary, #to_sym] object
    #   the object to extract a name from
    #
    # @return [Symbol]
    #
    # @api private
    def self.name_from(object)
      if object.respond_to?(:name)
        object.name
      elsif object.respond_to?(:to_ary)
        object.to_ary.first
      else
        object.to_sym
      end
    end

  private

    # Test that the value is either valid or optional
    #
    # @param [Object] value
    #   the value to test
    #
    # @yield [] block representing attribute constraint
    #
    # @return [Boolean]
    #
    # @api private
    def valid_or_optional?(value)
      value.nil? ? !required? : yield
    end

    memoize :hash

  end # class Attribute
end # module Veritas
