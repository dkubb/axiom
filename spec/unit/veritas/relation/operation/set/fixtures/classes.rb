module SetOperationSpecs
  class Object
    include Relation::Operation::Set

    def each(&block)
      left.each(&block)
      right.each(&block)
      self
    end

  end # class Object
end # module SetOperationSpecs
