module PredicateComparableSpecs
  class Object
    include Immutable
    include Logic::Predicate::Comparable

    attr_reader :left, :right

    def self.operation
      :==
    end

    def self.inverse
      self
    end

    def initialize(left, right)
      @left, @right = left, right
    end

  end # class Object
end # module PredicateComparableSpecs
