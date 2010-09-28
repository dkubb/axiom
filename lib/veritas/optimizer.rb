module Veritas

  # A optimization for an operation
  class Optimizer
    include AbstractClass, Immutable

    # A noop optimizer that returns the operation as-is
    Noop = lambda { |operation| operation }.freeze

    # The operation to optimize
    #
    # @return [Optimizable]
    #
    # @api private
    attr_reader :operation

    # Initialize an Optimizer
    #
    # @param [Optimizable] operation
    #   the operation to optimize
    #
    # @return [undefined]
    #
    # @api private
    def initialize(operation)
      @operation = operation
    end

    # Abstract method that tests if the optimization should be applied
    #
    # @example
    #   optimizer.optimizable?  # => true or false
    #
    # @return [Boolean]
    #
    # @api public
    def optimizable?
      raise NotImplementedError, "#{self.class}#optimizable? must be implemented"
    end

    # Abstract method that executes the optimization for the operation
    #
    # @example
    #   optimized = optimizer.optimize
    #
    # @return [Optimizable]
    #
    # @api public
    def optimize
      raise NotImplementedError, "#{self.class}#optimize must be implemented"
    end

    # Chain together a list of optimizer classes into a callable object
    #
    # @example
    #   Optimizer.chain(Optimizer::Foo, Optimizer::Bar)
    #
    # @param [Array<Class>] *optimizers
    #   a list of optimizer classes to apply
    #
    # @return [#call]
    #
    # @api public
    def self.chain(*optimizers)
      optimizers.reverse_each.reduce(Noop) do |successor, optimizer|
        link_optimizers(optimizer, successor)
      end
    end

    # Link an optimizer to a successor
    #
    # @param [Class] optimizer
    #   the optimizer to link to the successor
    # @param [#proc] successor
    #   the next optimizer to call if the current optimizer is not applied
    #
    # @return [#call]
    #
    # @api private
    def self.link_optimizers(optimizer, successor)
      lambda do |operation|
        op = optimizer.new(operation)
        op.optimizable? ? op.optimize : successor.call(operation)
      end
    end

    private_class_method :link_optimizers

  end # class Optimizer
end # module Veritas

require 'veritas/optimizer/relation'
require 'veritas/optimizer/algebra'
require 'veritas/optimizer/logic'
