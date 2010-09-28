module Veritas
  class Optimizer
    include AbstractClass, Immutable

    Noop = lambda { |operation| operation }.freeze

    attr_reader :operation

    def initialize(operation)
      @operation = operation
    end

    def optimizable?
      raise NotImplementedError, "#{self.class}#optimizable? must be implemented"
    end

    def optimize
      raise NotImplementedError, "#{self.class}#optimize must be implemented"
    end

    def self.chain(*optimizers)
      optimizers.reverse_each.reduce(Noop) do |successor, optimizer|
        link_optimizers(optimizer, successor)
      end
    end

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
