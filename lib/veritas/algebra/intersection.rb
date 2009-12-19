module Veritas
  module Algebra
    class Intersection < Relation
      include SetOperation

      def body
        @body ||= @left.body & @right.body
      end
    end # class Intersection
  end # module Algebra
end # module Veritas
