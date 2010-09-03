module UnaryOperationSpecs
  class Object < Relation
    include Relation::Operation::Unary

    def each(&block)
      operand.each(&block)
      self
    end

    def new(relation)
      self.class.new(relation)
    end

  end # class Object
end # module UnaryOperationSpecs
