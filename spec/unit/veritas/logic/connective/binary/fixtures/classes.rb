module BinarySpecs
  class Object
    include Logic::Connective::Binary

    def self.eval(*)
    end

  end # class Object

  class Complement < Object
    def eql?(other)
      equal?(other)
    end

  end # class Complement
end # module BinarySpecs
