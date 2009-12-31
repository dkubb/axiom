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
    end
  end
end
