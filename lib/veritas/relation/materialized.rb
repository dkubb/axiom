module Veritas
  class Relation
    class Materialized < Relation
      def empty?
        tuples.empty?
      end

      def size
        tuples.size
      end

    end # class Materialized
  end # class Relation
end # module Veritas
