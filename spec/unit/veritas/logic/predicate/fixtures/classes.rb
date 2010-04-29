module PredicateSpecs
  class Object < Veritas::Logic::Predicate
    def self.name
      'Veritas::Logic::Predicate'
    end

  end # class Object

  class AlwaysTrue < Veritas::Logic::Predicate
    def always_true?
      true
    end
  end # class AlwaysTrue

  class AlwaysFalse < Veritas::Logic::Predicate
    def always_false?
      true
    end
  end # class AlwaysFalse
end # module PredicateSpecs
