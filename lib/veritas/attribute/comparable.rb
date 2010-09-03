module Veritas
  class Attribute
    module Comparable
      include Orderable,
              Logic::Predicate::GreaterThan::Methods,
              Logic::Predicate::GreaterThanOrEqualTo::Methods,
              Logic::Predicate::LessThan::Methods,
              Logic::Predicate::LessThanOrEqualTo::Methods

      # TODO: figure out how to dry this up with Attribute#joinable?
      def comparable?(other)
        kind_of?(other.class) || other.kind_of?(self.class)
      end

    end # module Comparable
  end # class Attribute
end # module Veritas
