# encoding: utf-8

module Veritas

  # Abstract base class representing a type of data in a relation tuple
  class Attribute
    extend Aliasable, Comparator
    include AbstractClass, Immutable, ::Comparable, Visitable

    compare :name, :required?

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
    private :options

    # Hook called when class is inherited
    #
    # @param [Class] descendant
    #   the class inheriting Attribute
    #
    # @return [self]
    #
    # @api private
    def self.inherited(descendant)
      superclass = self.superclass
      superclass.inherited(descendant) if superclass.respond_to?(:descendants)
      descendants.unshift(descendant)
      self
    end

    # Return the descendants of this class
    #
    # @return [Array<Attribute>]
    #
    # @api private
    def self.descendants
      @descendants ||= []
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

    # Infer the Attribute type from the operand
    #
    # @param [Object] operand
    #
    # @return [Class<Attribute>]
    #
    # @api private
    def self.infer_type(operand)
      case operand
      when Attribute, Function, Aggregate then operand.type
      when FalseClass                     then Boolean
      else
        type = operand.class
        descendants.detect { |descendant| type <= descendant.primitive }
      end
    end

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
      tuple.call(self)
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

    # Return a string representing the attribute
    #
    # @example
    #   attribute.inspect  # => "<Attribute::Integer name: id>"
    #
    # @return [String]
    #
    # @api public
    def inspect
      klass      = self.class
      klass_name = klass.name.to_s
      "<#{klass_name.empty? ? klass.inspect : klass_name} name: #{name}>"
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
      value.nil? ? ! required? : yield
    end

    # Coerce the object into an Attribute
    #
    # @param [Attribute, Array] object
    #
    # @return [Attribute]
    #
    # @api private
    def coerce(object)
      Attribute.coerce(object)
    end

  end # class Attribute
end # module Veritas
