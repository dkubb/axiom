# encoding: utf-8

module Veritas

  # Define equality, equivalence and inspection methods
  class Equalizer < Module

    # Initialize an Equalizer with the given keys
    #
    # Will use the keys with which it is initialized to define #cmp?,
    # #hash, and #inspect
    #
    # @param [Module] mod
    #
    # @param [Array<Symbol>] *keys
    #
    # @return [undefined]
    #
    # @api private
    def initialize(mod, *keys)
      @name = Immutable.freeze_object(mod.name || mod.inspect)
      @keys = Immutable.freeze_object(keys)
      define_methods
      include_comparison_methods
    end

  private

    # Define the equalizer methods based on #keys
    #
    # @return [undefined]
    #
    # @api private
    def define_methods
      define_cmp_method
      define_hash_method
      define_inspect_method
    end

    # Define an #cmp? method based on the instance's values identified by #keys
    #
    # @return [undefined]
    #
    # @api private
    def define_cmp_method
      keys = @keys
      define_method(:cmp?) do |comparator, other|
        keys.all? { |key| send(key).send(comparator, other.send(key)) }
      end
      private :cmp?
    end

    # Define a #hash method based on the instance's values identified by #keys
    #
    # @return [undefined]
    #
    # @api private
    def define_hash_method
      keys = @keys
      define_method(:hash) do
        keys.map { |key| send(key).hash }.reduce(self.class.hash, :^)
      end
    end

    # Define an inspect method that reports the values of the instance's keys
    #
    # @return [undefined]
    #
    # @api private
    def define_inspect_method
      name, keys = @name, @keys
      define_method(:inspect) do
        "#<#{name}#{keys.map { |key| " #{key}=#{send(key).inspect}" }.join}>"
      end
    end

    # Include the #eql? and #== methods
    #
    # @return [undefined]
    #
    # @api private
    def include_comparison_methods
      module_eval do
        include Methods, Immutable
        memoize :hash
      end
    end

    # The comparison methods
    module Methods

      # Compare the object with other object for equality
      #
      # @example
      #   object.eql?(other)  # => true or false
      #
      # @param [Object] other
      #   the other object to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        instance_of?(other.class) and cmp?(__method__, other)
      end

      # Compare the object with other object for equivalency
      #
      # @example
      #   object == other  # => true or false
      #
      # @param [Object] other
      #   the other object to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def ==(other)
        other = coerce(other)
        return false unless self.class <=> other.class
        cmp?(__method__, other)
      end

    private

      # Coerce the object into something that can be compared
      #
      # @param [Object] other
      #
      # @return [Object]
      #
      # @api private
      def coerce(other)
        other
      end

    end # module Methods
  end # class Equalizer
end # module Veritas
