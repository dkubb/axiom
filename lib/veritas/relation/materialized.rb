module Veritas
  class Relation
    class Materialized < Relation
      def initialize(header, tuples, directions = Operation::Order::DirectionSet::EMPTY)
        super(header, tuples)
        @directions = Operation::Order::DirectionSet.coerce(directions)
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
