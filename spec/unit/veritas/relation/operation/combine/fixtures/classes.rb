module CombineOperationSpecs
  class Object < Relation
    include Relation::Operation::Combine

    def each
      left.each  { |tuple| yield tuple.project(header) }
      right.each { |tuple| yield tuple.project(header) }
      self
    end

  end # class Object
end # module CombineOperationSpecs
