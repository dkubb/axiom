module Veritas
  class Relation
    class Set
      def initialize(tuples, header)
        @tuples, @header = tuples, header
      end

      def each
        seen = {}
        @tuples.each do |tuple|
          tuple = Tuple.coerce(@header, tuple)
          yield(seen[tuple] = tuple) unless seen.key?(tuple)
        end
        self
      end

    end # class Set
  end # module Relation
end # module Veritas
