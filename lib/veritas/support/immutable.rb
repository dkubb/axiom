module Veritas
  module Immutable

    # Hook called when module is included
    #
    # @param [Module] descendant
    #   the module or class including Immutable
    #
    # @return [self]
    #
    # @api private
    def self.included(descendant)
      descendant.extend ModuleMethods if descendant.kind_of?(Module)
      descendant.extend ClassMethods  if descendant.kind_of?(Class)
      self
    end

    # A noop when there are no memoized methods
    #
    # @example
    #   object.memoize(:hash, 12345)  # => self
    #
    # @param [#to_s] name
    # @param [Object] value
    #
    # @return [self]
    #
    # @api public
    def memoize(name, value)
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
        when Numeric, TrueClass, FalseClass, NilClass
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
        include_memoize_methods
        methods.each { |method| memoize_method(method) }
        self
      end

    private

      # Mixin MemoizeMethods if it's not already
      #
      # @return [undefined]
      #
      # @api private
      def include_memoize_methods
        include MemoizeMethods unless include?(MemoizeMethods)
      end

      # Memoize the named method
      #
      # @param [#to_s] method
      #   a method to memoize
      #
      # @return [undefined]
      #
      # @api private
      def memoize_method(method)
        alias_name = "__memoized_#{method}"
        create_alias_for(method, alias_name)
        create_memoize_method_for(method, alias_name)
      end

      # Create an alias to a method
      #
      # @param [String, Symbol] original_method
      #   the name of the original method
      # @param [String, Symbol] alias_name
      #   the name of the new alias to create
      #
      # @return [undefined]
      #
      # @api private
      def create_alias_for(original_method, alias_name)
        alias_method alias_name, original_method
        private alias_name
      end

      # Create a memoized method that delegates to the original method
      #
      # @param [String, Symbol] new_method
      #   the name of the new method
      # @param [String, Symbol] alias_name
      #   the name of the alias to the original method
      #
      # @return [undefined]
      #
      # @api private
      def create_memoize_method_for(new_method, alias_name)
        visibility = method_visibility(new_method)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{new_method}(*args)                                # def name(*args)
            @__memory['@#{new_method}'] ||= #{alias_name}(*args)  #   @__memory['@name'] ||= __memoized_name(*args)
          end                                                     # end
        RUBY
        send(visibility, new_method)
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

    module MemoizeMethods

      # Freeze the object
      #
      # @example
      #   object.freeze  # object is now frozen
      #
      # @return [Object]
      #
      # @api public
      def freeze
        @__memory = Memory.new unless frozen?
        super
      end

      # Get the memoized value for a method
      #
      # @example
      #   hash = object.memoized(:hash)
      #
      # @param [#to_s] name
      #   the method name
      #
      # @return [Object]
      #
      # @api public
      def memoized(name)
        @__memory["@#{name}"]
      end

      # Sets a memoized value for a method
      #
      # @example
      #   object.memoize(:hash, 12345)
      #
      # @param [#to_s] name
      #   the method name
      # @param [Object] value
      #   the value to memoize
      #
      # @return [self]
      #
      # @api public
      def memoize(name, value)
        @__memory["@#{name}"] = value
        self
      end

    end # module MemoizeMethods

    class Memory

      # Get a frozen value from memory
      #
      # @example
      #   value = memory[ivar]
      #
      # @param [#to_s] ivar
      #   the name of the ivar to get the value for
      #
      # @return [Object]
      #
      # @api public
      alias [] instance_variable_get

      # Set a frozen value in memory
      #
      # @example
      #   memory[ivar] = value
      #
      # @param [#to_s] ivar
      #   the name of the ivar to set
      # @param [Object] value
      #   the value to set
      #
      # @return [undefined]
      #
      # @api public
      def []=(ivar, value)
        instance_variable_set(ivar, Immutable.freeze_object(value))
      end

    end # class Memory
  end # module Immutable
end # module Veritas
