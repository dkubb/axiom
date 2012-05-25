# encoding: utf-8

module Veritas

  # Allows objects to be made immutable
  module Immutable

    # Storage for memoized methods
    Memory = Class.new(::Hash)

    # Hook called when module is included
    #
    # @param [Module] descendant
    #   the module or class including Immutable
    #
    # @return [self]
    #
    # @api private
    def self.included(descendant)
      super
      descendant.extend ModuleMethods if descendant.kind_of?(Module)
      descendant.extend ClassMethods  if descendant.kind_of?(Class)
      self
    end

    # Attempt to freeze an object
    #
    # @example using a value object
    #   Immutable.freeze_object(12345)  # => noop
    #
    # @example using a normal object
    #   Immutable.freeze_object({})  # => duplicate & freeze object
    #
    # @param [Object] object
    #   the object to freeze
    #
    # @return [Object]
    #   if supported, the frozen object, otherwise the object directly
    #
    # @api public
    def self.freeze_object(object)
      case object
      when Numeric, TrueClass, FalseClass, NilClass, Symbol
        object
      else
        freeze_value(object)
      end
    end

    # Returns a frozen value
    #
    # @param [Object] value
    #   a value to freeze
    #
    # @return [Object]
    #   if frozen, the value directly, otherwise a frozen copy of the value
    #
    # @api private
    def self.freeze_value(value)
      value.frozen? ? value : value.dup.freeze
    end

    private_class_method :freeze_value

    # Freeze the object
    #
    # @example
    #   object.freeze  # object is now frozen
    #
    # @return [Object]
    #
    # @api public
    def freeze
      memory  # initialize memory
      super
    end

    # Get the memoized value for a method
    #
    # @example
    #   hash = object.memoized(:hash)
    #
    # @param [Symbol] name
    #   the method name
    #
    # @return [Object]
    #
    # @api public
    def memoized(name)
      memory[name]
    end

    # Sets a memoized value for a method
    #
    # @example
    #   object.memoize(:hash, 12345)
    #
    # @param [Symbol] name
    #   the method name
    # @param [Object] value
    #   the value to memoize
    #
    # @return [self]
    #
    # @api public
    def memoize(name, value)
      store_memory(name, value) unless memory.key?(name)
      self
    end

    # A noop #dup for immutable objects
    #
    # @example
    #   object.dup  # => self
    #
    # @return [self]
    #
    # @api public
    def dup
      self
    end

  private

    # The memoized method results
    #
    # @return [Hash]
    #
    # @api private
    def memory
      @__memory ||= Memory.new
    end

    # Store the value in memory
    #
    # @param [Symbol] name
    #   the method name
    # @param [Object] value
    #   the value to memoize
    #
    # @return [self]
    #
    # @return [value]
    #
    # @api private
    def store_memory(name, value)
      memory[name] = Immutable.freeze_object(value)
    end

    # Methods mixed in to immutable modules
    module ModuleMethods

      # Hook called when module is included
      #
      # @param [Module] mod
      #   the module including ModuleMethods
      #
      # @return [self]
      #
      # @api private
      def included(mod)
        Immutable.included(mod)
        self
      end

      # Memoize a list of methods
      #
      # @example
      #   memoize :hash
      #
      # @param [Array<#to_s>] *methods
      #   a list of methods to memoize
      #
      # @return [self]
      #
      # @api public
      def memoize(*methods)
        methods.each { |method| memoize_method(method) }
        self
      end

    private

      # Memoize the named method
      #
      # @param [#to_s] method
      #   a method to memoize
      #
      # @return [undefined]
      #
      # @api private
      def memoize_method(method)
        visibility = method_visibility(method)
        define_memoize_method(method)
        send(visibility, method)
      end

      # Define a memoized method that delegates to the original method
      #
      # @param [Symbol] method
      #   the name of the method
      #
      # @return [undefined]
      #
      # @api private
      def define_memoize_method(method)
        original = instance_method(method)
        undef_method(method)
        define_method(method) do |*args|
          if memory.key?(method)
            memoized(method)
          else
            store_memory(method, original.bind(self).call(*args))
          end
        end
      end

      # Return the method visibility of a method
      #
      # @param [String, Symbol] method
      #   the name of the method
      #
      # @return [String]
      #
      # @api private
      def method_visibility(method)
        if    private_method_defined?(method)   then 'private'
        elsif protected_method_defined?(method) then 'protected'
        else                                         'public'
        end
      end

    end # module ModuleMethods

    # Methods mixed in to immutable classes
    module ClassMethods

      # Instantiate a new frozen object
      #
      # @example
      #   object = ImmutableClass.new  # object is frozen
      #
      # @return [Object]
      #
      # @api public
      def new(*)
        super.freeze
      end

    end # module ClassMethods
  end # module Immutable
end # module Veritas
