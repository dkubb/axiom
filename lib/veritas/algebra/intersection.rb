module Veritas
  module Algebra
    class Intersection < Relation
      def initialize(left, right)
        @left, @right = left, right
      end
    end # class Intersection
  end # module Algebra
end # module Veritas
