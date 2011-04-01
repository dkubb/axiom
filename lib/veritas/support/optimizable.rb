module Veritas

  # Allow operations to be optimizable
  module Optimizable
    include Immutable

    # Hook called when module is included
    #
    # @param [Module] descendant
    #   the module or class including Optimizable
    #
    # @return [self]
    #
    # @api private
    def self.included(descendant)
      descendant.extend ClassMethods
      self
    end

    # Optimize the operation
    #
    # @example
    #   optimized = operation.optimize
    #
    # @param [Optimizer] optimizer
    #   optional optimizer
    #
    # @return [Optimizable]
    #   the optimized operation
    #
    # @api public
    #
    # @todo simplify by setting a default Noop optimizer for all relations
    def optimize(optimizer = self.class.optimizer || Optimizer::Noop)
      optimized = optimizer.call(self)
      equal?(optimized) ? self : optimized.optimize
    end

    memoize :optimize

    module ClassMethods

      # The Optimizer for the operation
      #
      # @return [Optimizable]
      #
      # @api private
      attr_accessor :optimizer

    end # module ClassMethods
  end # module Optimizable
end # module Veritas
