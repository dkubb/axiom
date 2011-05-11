module UnarySpecs
  class Object < Function
    include Function::Unary

    def inspect
      "Unary(#{operand.inspect})"
    end

  end # class Object
end # module UnarySpecs
