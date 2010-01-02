module Veritas
  class Relation
    class Header
      include Enumerable

      def initialize(attributes = [])
        @attributes = attributes.to_ary.map do |attribute|
          Attribute.coerce(attribute)
        end
      end

      def each(&block)
        to_ary.each(&block)
        self
      end

      def index(attribute)
        attribute = Attribute.coerce(attribute)
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
        to_set == self.class.coerce(other).to_set
      end

      def eql?(other)
        instance_of?(other.class) &&
        to_set.eql?(other.to_set)
      end

      def empty?
        to_ary.empty?
      end

    private

      def new(attributes)
        self.class.new(attributes)
      end

      def self.coerce(header)
        header.kind_of?(Header) ? header : new(header)
      end
    end # class Header
  end # class Relation
end # module Veritas
