module Veritas

  # Allow operations to be optimizable
  module Optimizable
    include Immutable

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
    def optimize(optimizer = self.class.optimizer)
      return self if optimizer.nil?
      optimized = optimizer.call(self)
      optimized.memoize(:optimize, optimized)
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
