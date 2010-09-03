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
        create_optimizer(optimizer, successor)
      end
    end

    def self.create_optimizer(optimizer, successor)
      lambda do |operation|
        op = optimizer.new(operation)
        op.optimizable? ? op.optimize : successor.call(operation)
      end
    end

    private_class_method :create_optimizer

  end # class Optimizer
end # module Veritas

require 'veritas/optimizer/relation'
require 'veritas/optimizer/algebra'
require 'veritas/optimizer/logic'
