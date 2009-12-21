module Veritas
  module Algebra
    class Join < Relation
      def self.new(left, right)
        if (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must have common attributes for #{self}.new"
        end

        super
      end
    end # class Product
  end # module Algebra
end # module Veritas
