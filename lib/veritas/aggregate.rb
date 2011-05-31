# encoding: utf-8

module Veritas

  # Abstract class for aggregate functions
  class Aggregate
    include AbstractClass, Immutable, Visitable, Operation::Unary

    # Return the default accumulator
    #
    # @example
    #   default = Aggregate.default
    #
    # @return [Object]
    #
    # @api public
    def self.default
      self::DEFAULT
    end

    # Evaluate the aggregate using the operands
    #
    # @example
    #   Aggregate.call  # => raises NotImplementedError
    #
    # @return [Object]
    #
    # @api public
    def self.call(*)
      raise NotImplementedError, "#{name}.call must be implemented"
    end

    # Returns the value extracted from the accumulator
    #
    # Default behaviour is to pass-through the accumulator
    #
    # @example
    #   value = Aggregate.finalize(accumulator)
    #
    # @return [Object]
    #
    # @api public
    def self.finalize(accumulator)
      accumulator
    end

    # Return the default for this aggregate
    #
    # @example
    #   default = aggregate.default
    #
    # @return [Object]
    #
    # @api public
    def default
      self.class.default
    end

    # Evaluate the aggregate using the provided Tuple
    #
    # @example
    #   accumulator = aggregate.call(accumulator, tuple)
    #
    # @param [Object] accumulator
    #
    # @param [Tuple] tuple
    #
    # @return [Object]
    #
    # @api public
    def call(accumulator, tuple)
      self.class.call(accumulator, value(tuple))
    end

    # Finalize the accumulator value
    #
    # @example
    #   value = aggregate.finalize(accumulator)
    #
    # @return [Object]
    #
    # @api public
    def finalize(accumulator)
      self.class.finalize(accumulator)
    end

    # Return the type returned from #call
    #
    # @return [Class<Attribute>]
    #
    # @api public
    def type
      raise NotImplementedError, "#{self.class}#type must be implemented"
    end

  private

    # Extract the value from the operand or tuple
    #
    # @param [Object, #call] operand
    #   the operand to extract the value from
    # @param [Tuple] tuple
    #   the tuple to pass in to the operand if it responds to #call
    #
    # @return [Object]
    #
    # @todo Aggregate will inherit from Function, then use as Function.value
    #
    # @api private
    def value(tuple)
      operand = self.operand
      operand.respond_to?(:call) ? operand.call(tuple) : operand
    end

  end # class Aggregate
end # module Veritas
