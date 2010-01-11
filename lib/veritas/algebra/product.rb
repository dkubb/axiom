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
        body = []

        right.each do |right_tuple|
          body.concat CombineOperation.combine_tuples(left, right_tuple)
        end

        body
      end

    end # class Product
  end # module Algebra
end # module Veritas
