module PredicateSpecs
  class Object < Logic::Predicate
    def self.name
      'Veritas::Logic::Predicate'
    end

    def self.complement
      self
    end

  end # class Object

  class AlwaysTrue < Logic::Predicate
    def always_true?
      true
    end
  end # class AlwaysTrue

  class AlwaysFalse < Logic::Predicate
    def always_false?
      true
    end
  end # class AlwaysFalse
end # module PredicateSpecs
