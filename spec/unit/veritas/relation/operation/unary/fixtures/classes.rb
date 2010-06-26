module UnaryOperationSpecs
  class Object
    include Veritas::Relation::Operation::Unary

    def each(&block)
      relation.each(&block)
      self
    end

  end # class Object
end # module UnaryOperationSpecs
