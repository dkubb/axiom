module Veritas
  class Attribute
    module Comparable
      include Orderable

      # TODO: figure out how to dry this up with Attribute#joinable?
      def comparable?(other)
        kind_of?(other.class) || other.kind_of?(self.class)
      end

      def gte(other)
        Logic::Predicate::GreaterThanOrEqualTo.new(self, other)
      end

      def gt(other)
        Logic::Predicate::GreaterThan.new(self, other)
      end

      def lte(other)
        Logic::Predicate::LessThanOrEqualTo.new(self, other)
      end

      def lt(other)
        Logic::Predicate::LessThan.new(self, other)
      end
    end
  end
end
