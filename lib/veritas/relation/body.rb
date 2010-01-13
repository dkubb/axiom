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
          tuple = Tuple.coerce(@header, tuple)
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

    private

      def project(body)
        Algebra::Projection::Body.new(body, header)
      end

      def new(tuples)
        self.class.new(tuples, header)
      end

      def coerce(object)
        object.kind_of?(Body) ? object : new(object)
      end

    end # class Body
  end # class Relation
end # module Veritas
