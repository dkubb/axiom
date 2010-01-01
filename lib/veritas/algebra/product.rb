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

        left.each do |left_tuple|
          right.each do |right_tuple|
            body << left_tuple + right_tuple
          end
        end

        Body.new(header, body)
      end
    end # class Product
  end # module Algebra
end # module Veritas
