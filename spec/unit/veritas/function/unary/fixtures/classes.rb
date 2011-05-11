module UnarySpecs
  class Object
    include Function::Unary

    def inspect
      "Unary(#{operand.inspect})"
    end

  end # class Object
end # module UnarySpecs
