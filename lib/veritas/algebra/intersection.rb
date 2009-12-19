module Veritas
  module Algebra
    class Intersection < Relation
      def self.new(left, right)
        unless left.header == right.header
          raise HeaderMismatchError, 'the headers must be equivalent to be intersected'
        end

        super
      end

      def initialize(left, right)
        @left, @right = left, right
      end
    end # class Intersection
  end # module Algebra
end # module Veritas
