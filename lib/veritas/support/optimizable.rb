module Veritas
  module Optimizable
    include Immutable

    def self.included(descendant)
      descendant.extend ClassMethods
    end

    def optimize(optimizer = self.class.optimizer)
      return self if optimizer.nil?
      optimized = optimizer.call(self)
      optimized.memoize(:optimize, optimized)
    end

    memoize :optimize

    module ClassMethods
      attr_accessor :optimizer
    end # module ClassMethods
  end # module Optimizable
end # module Veritas
