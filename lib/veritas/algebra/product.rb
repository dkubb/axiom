module Veritas
  module Algebra
    class Product < Relation
      include BinaryOperation

      def self.new(left, right)
        if left.header == right.header
          raise InvalidHeaderError, "the headers must be different for #{self}.new"
        end

        super
      end

      def body
        @body ||= multiply_bodies
      end

      private

      def multiply_bodies
        body = []

        left.body.each do |left_tuple|
          right.body.each do |right_tuple|
            body << left_tuple + right_tuple
          end
        end

        body
      end
    end # class Product
  end # module Algebra
end # module Veritas
