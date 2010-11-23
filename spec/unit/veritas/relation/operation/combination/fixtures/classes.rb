module CombinationOperationSpecs
  class Object < Relation
    include Relation::Operation::Combination

    def each
      left.each  { |tuple| yield tuple.project(header) }
      right.each { |tuple| yield tuple.project(header) }
      self
    end

  end # class Object
end # module CombinationOperationSpecs
