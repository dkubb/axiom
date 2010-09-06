module Veritas
  class Relation
    class Materialized < Relation
      def initialize(header, tuples, directions = nil)
        super(header, tuples)
        @directions = Operation::Order::DirectionSet.coerce(directions) if directions
      end

      def empty?
        tuples.empty?
      end

      def size
        tuples.size
      end

    end # class Materialized
  end # class Relation
end # module Veritas
