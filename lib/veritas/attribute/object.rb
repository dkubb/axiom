module Veritas
  class Attribute
    class Object < Attribute
      def eq(other)
        Algebra::Restriction::Equality.new(self, other)
      end

      def ne(other)
        Algebra::Restriction::Inequality.new(self, other)
      end

      def in(other)
        Algebra::Restriction::Inclusion.new(self, other)
      end
    end # class Object
  end # class Attribute
end # module Veritas
