module Veritas
  class Relation
    class Body
      include Enumerable

      attr_reader :header

      def initialize(tuples, header)
        @tuples, @header = tuples, header
      end

      def each
        seen = {}
        @tuples.each do |tuple|
          tuple = Tuple.coerce(header, tuple)
          yield(seen[tuple] = tuple) unless seen.key?(tuple)
        end
        self
      end

      def ==(other)
        other  = coerce(other)
        header = self.header
        header == other.header &&
        to_set == project(other).to_set
      end

      def eql?(other)
        header = self.header
        instance_of?(other.class) &&
        header.eql?(other.header) &&
        to_set == project(other).to_set
      end

      def hash
        to_set.hash
      end

      def inspect
        to_a.inspect
      end

    private

      def project(tuples)
        Algebra::Projection::Body.new(tuples, header)
      end

      def new(tuples)
        Body.new(tuples, header)
      end

      def coerce(object)
        object.kind_of?(Body) ? object : new(object)
      end

    end # class Body
  end # class Relation
end # module Veritas
