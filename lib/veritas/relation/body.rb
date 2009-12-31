require 'set'

module Veritas
  class Relation
    class Body
      include Enumerable

      attr_reader :header

      def initialize(header, tuples = Set.new)
        @header, @tuples = header, tuples.to_set
      end

      def each(&block)
        @tuples.each(&block)
        self
      end

      def intersect(other)
        new(@tuples & other.to_set)
      end

      alias & intersect

      def union(other)
        new(@tuples | other.to_set)
      end

      alias | union

      def difference(other)
        new(@tuples - other.to_set)
      end

      alias - difference

      def to_set
        @tuples
      end

      def ==(other)
        other = new(other) unless kind_of?(other.class)
        header  == other.header &&
        @tuples == other.to_set
      end

      def eql?(other)
        instance_of?(other.class) &&
        header.eql?(other.header) &&
        @tuples.eql?(other.to_set)
      end

    private

      def new(other)
        self.class.new(header, other)
      end
    end
  end
end
