module Veritas
  module Algebra
    class Product < Relation
      include CombineOperation

      def self.new(left, right)
        unless (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must be disjointed for #{name}.new"
        end

        super
      end

    private

      def combine_bodies
        Algebra::Product::Set.new(left, right)
      end

    end # class Product
  end # module Algebra
end # module Veritas

require 'veritas/algebra/product/set'
