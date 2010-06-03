module PredicateComparableSpecs
  class Object
    include Veritas::Logic::Predicate::Comparable

    attr_reader :left, :right

    def self.operation
      :==
    end

    def self.complement
      Complement
    end

    def initialize(left, right)
      @left, @right = left, right
    end
  end # class Object

  class Complement
    attr_reader :left, :right

    def initialize(left, right)
      @left, @right = left, right
    end
  end # class Complement
end # module PredicateComparableSpecs
