# encoding: utf-8

module SetOperationSpecs
  class Object < Relation
    include Relation::Operation::Set

    def each(&block)
      left.each(&block)
      right.each(&block)
      self
    end

  end # class Object
end # module SetOperationSpecs
