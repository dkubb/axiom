module Veritas
  class Attribute
    module Comparable
      include Orderable

      # TODO: figure out how to dry this up with Attribute#joinable?
      def comparable?(other)
        !(self.class <=> other.class).nil?
      end

      def gte(other)
        Algebra::Restriction::GreaterThanOrEqualTo.new(self, other)
      end

      def gt(other)
        Algebra::Restriction::GreaterThan.new(self, other)
      end

      def lte(other)
        Algebra::Restriction::LessThanOrEqualTo.new(self, other)
      end

      def lt(other)
        Algebra::Restriction::LessThan.new(self, other)
      end
    end
  end
end
