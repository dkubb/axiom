module AbstractClassSpecs
  class Object
    include Veritas::AbstractClass
  end # class Object

  class Subclass < Object; end
end # module AbstractClassSpecs
