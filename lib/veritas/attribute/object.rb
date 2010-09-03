module Veritas
  class Attribute
    class Object < Attribute
      include Logic::Predicate::Equality::Methods,
              Logic::Predicate::Exclusion::Methods,
              Logic::Predicate::Inequality::Methods,
              Logic::Predicate::Inclusion::Methods

      def self.primitive
        ::Object
      end

    end # class Object
  end # class Attribute
end # module Veritas
