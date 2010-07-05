module AbstractClassSpecs
  class Object
    include AbstractClass
  end # class Object

  class Subclass < Object; end
end # module AbstractClassSpecs
