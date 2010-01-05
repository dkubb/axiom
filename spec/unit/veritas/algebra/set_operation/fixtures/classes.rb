module SetOperationSpecs
  class Object
    include Veritas::Algebra::SetOperation
  end

  class Union
    include Veritas::Algebra::SetOperation

    def self.operation
      :union
    end
  end
end
