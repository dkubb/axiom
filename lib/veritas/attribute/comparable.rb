module Veritas
  class Attribute
    module Comparable
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

      def asc
        Relation::Operation::Order::Ascending.new(self)
      end

      def desc
        Relation::Operation::Order::Descending.new(self)
      end
    end
  end
end
