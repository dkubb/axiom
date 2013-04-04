# encoding: utf-8

module Axiom

  # Abstract class for aggregate functions
  class Aggregate
    include AbstractType, Visitable, Operation::Unary
    include Equalizer.new(:operand)

    abstract_singleton_method :call
    abstract_method :type

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

  private

    # Extract the value from the operand or tuple
    #
    # @param [Tuple] tuple
    #   the tuple to pass in to the operand if it responds to #call
    #
    # @return [Object]
    #
    # @api private
    def value(tuple)
      Function.extract_value(operand, tuple)
    end

  end # class Aggregate
end # module Axiom
