# encoding: utf-8

module BinaryRelationOperationSpecs
  class Object < Relation
    include Relation::Operation::Binary

    def each(&block)
      left.each(&block)
      right.each(&block)
      self
    end

  end # class Object
end # module BinaryRelationOperationSpecs
