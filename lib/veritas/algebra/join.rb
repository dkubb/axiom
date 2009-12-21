module Veritas
  module Algebra
    class Join < Relation
      include BinaryOperation

      def self.new(left, right)
        if (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must have common attributes for #{self}.new"
        end

        super
      end

      def header
        @header ||= left.header | right.header
      end
    end # class Product
  end # module Algebra
end # module Veritas
