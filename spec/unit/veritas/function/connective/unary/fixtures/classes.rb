module UnarySpecs
  class Object < Function::Connective::Unary
    def inspect
      "Unary(#{operand.inspect})"
    end

  end # class Object
end # module UnarySpecs
