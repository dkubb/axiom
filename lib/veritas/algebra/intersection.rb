module Veritas
  module Algebra
    class Intersection < Relation
      include Relation::Operation::Set

      def each
        right_set = right.to_set
        left.each { |tuple| yield(tuple) if right_set.include?(tuple) }
        self
      end

      module Methods
        extend Aliasable

        inheritable_alias(:& => :intersect)

        def intersect(other)
          Intersection.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Intersection
  end # module Algebra
end # module Veritas
