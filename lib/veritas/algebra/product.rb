module Veritas
  module Algebra
    class Product < Relation
      include Relation::Operation::Combine

      def self.new(left, right)
        unless (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must be disjointed for #{name}.new"
        end

        super
      end

      def each(&block)
        left.each do |tuple|
          Relation::Operation::Combine.combine_tuples(header, tuple, right, &block)
        end
        self
      end

    end # class Product
  end # module Algebra
end # module Veritas
