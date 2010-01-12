module Veritas
  class Relation
    class Body
      include Enumerable

      attr_reader :header

      def initialize(header, tuples)
        @header, @tuples = header, Set.new(tuples, header)
      end

      def each(&block)
        @tuples.each(&block)
        self
      end

      def empty?
        to_set.empty?
      end

      def ==(other)
        other  = coerce(other)
        header = self.header
        header == other.header &&
        to_set == other.send(:project, header).to_set
      end

      def eql?(other)
        header = self.header
        instance_of?(other.class) &&
        header.eql?(other.header) &&
        to_set == other.send(:project, header).to_set
      end

    private

      def project(header)
        self.class.new(header, Algebra::Projection::Set.new(self, header))
      end

      def new(tuples)
        self.class.new(header, tuples)
      end

      def coerce(object)
        object.kind_of?(Body) ? object : new(object)
      end

    end # class Body
  end # class Relation
end # module Veritas
