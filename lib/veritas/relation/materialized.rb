module Veritas
  class Relation
    class Materialized < Relation
      def size
        tuples.size
      end

      def optimize
        empty? ? new_empty_relation : super
      end

    end # class Materialized
  end # class Relation
end # module Veritas
