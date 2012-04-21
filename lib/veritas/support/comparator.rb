# encoding: utf-8

module Veritas

  # Allows objects to be compared
  module Comparator

    # Setup default comparison methods for the object
    #
    # @example
    #   compare :left, :right
    #
    # @param [Array<Symbol>] *methods
    #
    # @return [self]
    #
    # @api public
    def compare(*methods)
      include Methods
      define_hash_method(methods)
      define_comparison_method(methods)
      memoize :hash
      private :cmp?
      self
    end

  private

    # Define a #hash method on the object
    #
    # The list of methods specify which methods' return values should be hashed
    # and XOR'd together with the class's hash.
    #
    # @param [Array<#to_s>] methods
    #
    # @return [undefined]
    #
    # @api private
    def define_hash_method(methods)
      define_method(:hash) do
        methods.map { |method| send(method).hash }.reduce(self.class.hash, :^)
      end
    end

    # Define a private comparison method on the object
    #
    # The list of methods specify which methods' return values should be
    # compared together using #== or #eql?
    #
    # @param [Array<#to_s>] methods
    #
    # @return [undefined]
    #
    # @api private
    def define_comparison_method(methods)
      define_method(:cmp?) do |comparator, other|
        methods.all? { |method| send(method).send(comparator, other.send(method)) }
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
        instance_of?(other.class) && cmp?(__method__, other)
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
  end # module Comparator
end # module Veritas
