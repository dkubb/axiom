module BinaryConnectiveSpecs
  class Object
    include Logic::Connective::BinaryConnective

    def self.eval(*)
    end

  end # class Object

  class Complement < Object
    def eql?(other)
      equal?(other)
    end

  end # class Complement
end # module BinaryConnectiveSpecs
