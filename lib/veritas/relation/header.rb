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
        new(to_ary & other)
      end

      alias & intersect

      def union(other)
        new(to_ary | other)
      end

      alias | union

      def difference(other)
        new(to_ary - other)
      end

      alias - difference

      def to_ary
        @attributes
      end

      def ==(other)
        to_set == other.to_set
      end

      def eql?(other)
        instance_of?(other.class) &&
        self == other
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
