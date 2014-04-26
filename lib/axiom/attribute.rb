# encoding: utf-8

module Axiom

  # Abstract base class representing a type of data in a relation tuple
  class Attribute
    extend Aliasable, DescendantsTracker
    include AbstractType, ::Comparable, Visitable, AST::Sexp
    include Equalizer.new(:name, :type, :required?)

    abstract_singleton_method :type

    # The attribute name
    #
    # @return [Symbol]
    #
    # @api private
    attr_reader :name

    # The attribute type
    #
    # @return [Class<Types::Object>]
    #
    # @api private
    attr_reader :type

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
      elsif equal?(Attribute)
        Object.coerce(object)
      else
        name, type, options = object
        klass = type ? const_get(type.name) : self
        klass.new(name, options || EMPTY_HASH)
      end
    end

    # Extract the attribute name from the object
    #
    # @param [#name, #to_ary, #to_a] object
    #   the object to extract a name from
    #
    # @return [Symbol]
    #
    # @api private
    def self.name_from(object)
      if object.respond_to?(:name)
        object.name
      else
        Array(object).first.to_sym
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
      if operand.respond_to?(:type)
        operand.type
      else
        Types::Type.descendants.detect { |type| type.include?(operand) }
      end
    end

    # Initialize an Attribute
    #
    # @param [#to_sym] name
    #   the attribute name
    # @param [Hash] options
    #   the options for the attribute
    # @option options [Boolean] :required (true)
    #   if true, then the value cannot be nil
    #
    # @return [undefined]
    #
    # @api private
    def initialize(name, options = EMPTY_HASH)
      @name     = name.to_sym
      @required = options.fetch(:required, true)
      @type     = self.class.type
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
      if name.equal?(new_name)
        self
      else
        self.class.new(new_name, required: required?)
      end
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

    # Test if the attribute is optional
    #
    # @example
    #   attribute.optional?  # => true or false
    #
    # @return [Boolean]
    #
    # @api public
    def optional?
      !required?
    end

    # Test if the value matches the attribute constraints
    #
    # @example
    #   attribute.include?(value)  # => true or false
    #
    # @param [Object] value
    #   the value to test
    #
    # @return [Boolean]
    #
    # @api public
    def include?(value)
      valid_or_optional?(value, &type.method(:include?))
    end

    def to_ast
      s(:attr, name, type)
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
      value.nil? ? optional? : yield(value)
    end

    # Coerce the object into an Attribute
    #
    # @param [Array] args
    #
    # @return [Attribute]
    #
    # @api private
    def coerce(*args)
      self.class.coerce(*args)
    end

  end # class Attribute
end # module Axiom
