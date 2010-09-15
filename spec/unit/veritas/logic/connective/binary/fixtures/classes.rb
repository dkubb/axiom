module BinarySpecs
  class Object
    include Logic::Connective::Binary

    def self.call(*)
    end

  end # class Object

  class Negation < Object
    def eql?(other)
      equal?(other)
    end

  end # class Negation
end # module BinarySpecs
