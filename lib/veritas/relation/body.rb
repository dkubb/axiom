require 'set'

module Veritas
  class Relation
    class Body
      include Enumerable

      attr_reader :header

      def initialize(header, tuples = Set.new)
        @header = header
        @tuples = tuples.map { |tuple| Tuple.coerce(@header, tuple) }.to_set
      end

      def each(&block)
        to_set.each(&block)
        self
      end

      def project(header)
        self.class.new(header, map { |tuple| tuple.project(header) })
      end

      def intersect(other)
        new(to_set & other)
      end

      def union(other)
        new(to_set | other)
      end

      def difference(other)
        new(to_set - other)
      end

      def to_set
        @tuples
      end

      def ==(other)
        other  = coerce(other)
        header = self.header
        header == other.header &&
        to_set == other.project(header).to_set
      end

      def eql?(other)
        header = self.header
        instance_of?(other.class) &&
        header.eql?(other.header) &&
        to_set == other.project(header).to_set
      end

    private

      def new(tuples)
        self.class.new(header, tuples)
      end

      def coerce(body)
        body.kind_of?(Body) ? body : new(body)
      end

    end # class Body
  end # class Relation
end # module Veritas
