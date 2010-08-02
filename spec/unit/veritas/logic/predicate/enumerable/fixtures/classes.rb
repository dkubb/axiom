require 'spec/mocks'

module PredicateEnumerableSpecs
  class Object < Logic::Predicate
    include Spec::Mocks::ExampleMethods
    include Logic::Predicate::Enumerable

    def self.mock_one
      raise NotImplementedError, "#{self}.mock_one should be stubbed"
    end

    def self.mock_none
      raise NotImplementedError, "#{self}.mock_none should be stubbed"
    end

    def new_optimized_one
      self.class.mock_one
    end

    def new_optimized_none
      self.class.mock_none
    end

    # required for heckle
    def optimize
      super
    end

    def inspect
      "#{left.inspect} #{right.inspect}"
    end

    memoize :optimize
  end # class Object
end # module PredicateEnumerableSpecs
