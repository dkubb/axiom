module Veritas
  module Algebra
    class Product < Relation
      def self.new(left, right)
        if left.header == right.header
          raise InvalidHeaderError, "the headers must be different for #{self}.new"
        end

        super
      end
    end # class Product
  end # module Algebra
end # module Veritas
