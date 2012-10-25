# encoding: utf-8

module PredicateComparableSpecs
  class Object
    include Adamantium
    include Function::Comparable

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
