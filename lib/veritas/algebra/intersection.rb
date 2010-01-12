module Veritas
  module Algebra
    class Intersection < Relation
      include SetOperation

      def self.operation
        :intersect
      end

    end # class Intersection
  end # module Algebra
end # module Veritas

require 'veritas/algebra/intersection/set'
