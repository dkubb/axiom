module UnarySpecs
  class Object < Logic::Connective::Unary
    def inspect
      "Unary(#{operand.inspect})"
    end

  end # class Object
end # module UnarySpecs
