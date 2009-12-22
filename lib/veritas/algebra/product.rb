module Veritas
  module Algebra
    class Product < Relation
      include BinaryOperation

      def self.new(left, right)
        unless (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must be disjointed for #{name}.new"
        end

        super
      end

      def header
        @header ||= left.header | right.header
      end

      def body
        @body ||= join_bodies
      end

      private

      def join_bodies
        body = []

        left.each do |left_tuple|
          right.each do |right_tuple|
            body << left_tuple + right_tuple
          end
        end

        body
      end
    end # class Product
  end # module Algebra
end # module Veritas
