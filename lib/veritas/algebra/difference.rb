module Veritas
  module Algebra
    class Difference < Relation
      include Relation::Operation::Set

      def each
        right_set = right.to_set
        left.each { |tuple| yield(tuple) unless right_set.include?(tuple) }
        self
      end

    end # class Difference
  end # module Algebra
end # module Veritas
