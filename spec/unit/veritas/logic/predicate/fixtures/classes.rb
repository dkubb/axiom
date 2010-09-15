module PredicateSpecs
  class Object < Logic::Predicate
    def self.name
      'Veritas::Logic::Predicate'
    end

    def self.inverse
      self
    end

  end # class Object
end # module PredicateSpecs
