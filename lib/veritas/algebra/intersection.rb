module Veritas
  module Algebra
    class Intersection < Relation
      include SetOperation

      def self.operation
        :&
      end

    end # class Intersection
  end # module Algebra
end # module Veritas
