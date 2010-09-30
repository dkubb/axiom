module BinarySpecs
  class Object < Logic::Connective::Binary
    def inspect
      "Binary(#{left.inspect}, #{right.inspect})"
    end

  end # class Object
end # module BinarySpecs
