# encoding: utf-8

module Veritas

  # Define equality, equivalence and inspection methods
  class Equalizer < Module

    # Initialize an Equalizer with the given keys
    #
    # Will use the keys with which it is initialized to define #cmp?,
    # #hash, and #inspect
    #
    # @param [Array<Symbol>] *keys
    #
    # @return [undefined]
    #
    # @api private
    def initialize(*keys)
      @keys = Adamantium::Freezer::Deep.call(keys)
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
      keys = @keys
      define_method(:inspect) do
        klass = self.class
        name  = klass.name || klass.inspect
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
        include Methods, Adamantium
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
        other = coerce(other) if respond_to?(:coerce, true)
        return false unless self.class <=> other.class
        cmp?(__method__, other)
      end

    end # module Methods
  end # class Equalizer
end # module Veritas
