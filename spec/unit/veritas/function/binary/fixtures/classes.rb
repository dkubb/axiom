module BinarySpecs
  class Object
    include Function::Binary

    def inspect
      "Binary(#{left.inspect}, #{right.inspect})"
    end

  end # class Object
end # module BinarySpecs
