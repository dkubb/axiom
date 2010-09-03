module Veritas
  module Algebra
    class Difference < Relation
      include Relation::Operation::Set

      def each
        right_set = right.to_set
        left.each { |tuple| yield(tuple) unless right_set.include?(tuple) }
        self
      end

      module Methods
        extend Aliasable

        inheritable_alias(:- => :difference)

        def difference(other)
          Difference.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Difference
  end # module Algebra
end # module Veritas
