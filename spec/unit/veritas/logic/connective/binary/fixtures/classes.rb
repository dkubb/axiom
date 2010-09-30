module BinarySpecs
  class Object < Logic::Connective::Binary
    def self.call(*)
    end

    def inspect
      "Binary(#{left.inspect}, #{right.inspect})"
    end

  end # class Object

  class Negation < Object
    def eql?(other)
      equal?(other)
    end

  end # class Negation
end # module BinarySpecs
