module AbstractClassSpecs
  class Object
    include Veritas::AbstractClass
  end

  class Subclass < Object; end
end
