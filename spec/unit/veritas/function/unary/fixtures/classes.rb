# encoding: utf-8

module UnarySpecs
  class Object < Function
    include Function::Unary, Function::Unary::Invertible

    def inspect
      "Unary(#{operand.inspect})"
    end

  end # class Object
end # module UnarySpecs
