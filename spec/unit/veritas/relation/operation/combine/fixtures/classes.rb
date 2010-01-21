module CombineOperationSpecs
  class Object
    include Veritas::Relation::Operation::Combine

    def each
      left.each  { |tuple| yield tuple.project(header) }
      right.each { |tuple| yield tuple.project(header) }
      self
    end

    def new_empty_relation
      raise NotImplementedError, "#{self.class}#new_empty_relation"
    end

  end # class Object
end # module CombineOperationSpecs
