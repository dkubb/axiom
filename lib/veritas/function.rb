module Veritas

  # Abstract base class for logical functions
  class Function
    include AbstractClass, Immutable, Visitable

    # Rename the attribute(s) inside the function
    #
    # @param [Function] operand
    #
    # @param [Algebra::Rename::Aliases] aliases
    #
    # @return [Function]
    #
    # @todo simplify once Attribute#rename works the same as Function#rename
    #
    # @api private
    def self.rename_attributes(operand, aliases)
      if operand.respond_to?(:rename) && !operand.kind_of?(Attribute)
        operand.rename(aliases)
      else
        aliases[operand]
      end
    end

    # Extract the value from the operand or tuple
    #
    # @param [Object, #call] operand
    #   the operand to extract the value from
    # @param [Tuple] tuple
    #   the tuple to pass in to the operand if it responds to #call
    #
    # @return [Object]
    #
    # @api private
    def self.extract_value(operand, tuple)
      operand.respond_to?(:call) ? operand.call(tuple) : operand
    end

    # Evaluate the function using the operands
    #
    # @return [undefined]
    #
    # @api public
    def self.call(*)
      raise NotImplementedError, "#{name}.call must be implemented"
    end

    # Rename the contained attributes with the provided aliases
    #
    # @example
    #   renamed = function.rename(aliases)
    #
    # @param [Algebra::Rename::Aliases] aliases
    #   the old and new attributes
    #
    # @return [Function]
    #
    # @api public
    def rename(aliases)
      raise NotImplementedError, "#{self.class}#rename must be implemented"
    end

    # Compare the function with other function for equivalency
    #
    # @example
    #   function == other  # => true or false
    #
    # @param [Function] other
    #
    # @return [Boolean]
    #
    # @api public
    def ==(other)
      raise NotImplementedError, "#{self.class}#== must be implemented"
    end

    # Compare the function with other function for equality
    #
    # @example
    #   function.eql?(other)  # => true or false
    #
    # @param [Function] other
    #
    # @return [Boolean]
    #
    # @api public
    def eql?(other)
      raise NotImplementedError, "#{self.class}#eql? must be implemented"
    end

    # Return the hash of the function
    #
    # @example
    #   hash = function.hash
    #
    # @return [Fixnum]
    #
    # @api public
    def hash
      raise NotImplementedError, "#{self.class}#hash must be implemented"
    end

    # Return a string representing the function
    #
    # @example
    #   function.inspect  # (String representation of Function)
    #
    # @return [String]
    #
    # @api public
    def inspect
      raise NotImplementedError, "#{self.class}#inspect must be implemented"
    end

  end # class Function
end # module Veritas
