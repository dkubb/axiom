module Veritas
  class Attribute
    class Object < Attribute
      def eq(other)
        Logic::Predicate::Equality.new(self, other)
      end

      def ne(other)
        Logic::Predicate::Inequality.new(self, other)
      end

      def in(other)
        Logic::Predicate::Inclusion.new(self, other)
      end

      def self.primitive
        ::Object
      end
    end # class Object
  end # class Attribute
end # module Veritas
