module CombineOperationSpecs
  class Object
    include Veritas::Relation::Operation::Combine

    def each
      left.each  { |tuple| yield tuple.project(header) }
      right.each { |tuple| yield tuple.project(header) }
      self
    end
  end
end
