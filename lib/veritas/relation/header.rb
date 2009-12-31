module Veritas
  class Relation
    class Header
      include Enumerable

      def initialize(attributes = [])
        @attributes = attributes.to_ary
      end

      def each(&block)
        to_ary.each(&block)
        self
      end

      def index(attribute)
        to_ary.index(attribute)
      end

      def size
        to_ary.size
      end

      def intersect(other)
        new(to_ary & other.to_ary)
      end

      alias & intersect

      def union(other)
        new(to_ary | other.to_ary)
      end

      alias | union

      def difference(other)
        new(to_ary - other.to_ary)
      end

      alias - difference

      def to_ary
        @attributes
      end

      def ==(other)
        to_ary == other.to_ary
      end

      def eql?(other)
        instance_of?(other.class) &&
        to_ary.eql?(other.to_ary)
      end

      def empty?
        to_ary.empty?
      end

    private

      def new(attributes)
        self.class.new(attributes)
      end
    end
  end
end
