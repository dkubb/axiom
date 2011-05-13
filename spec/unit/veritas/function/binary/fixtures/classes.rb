# encoding: utf-8

module BinarySpecs
  class Object < Function
    include Function::Binary

    def inspect
      "Binary(#{left.inspect}, #{right.inspect})"
    end

  end # class Object
end # module BinarySpecs
