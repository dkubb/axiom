module Veritas
  module Algebra
    class Product < Relation
      include Relation::Operation::Combine

      def self.new(left, right)
        assert_disjointed_headers(left, right)
        super
      end

      class << self
      private

        def assert_disjointed_headers(left, right)
          if (left.header & right.header).any?
            raise InvalidHeaderError, "the headers must be disjointed for #{name}.new"
          end
        end

      end

      def each(&block)
        left.each do |tuple|
          Relation::Operation::Combine.combine_tuples(header, tuple, right, &block)
        end
        self
      end

      def optimize
        left, right = optimize_left, optimize_right

        if left.header.empty? && !left.kind_of?(Relation::Empty)
          right
        elsif right.header.empty? && !right.kind_of?(Relation::Empty)
          left
        else
          super
        end
      end

      module Methods
        extend Aliasable

        inheritable_alias(:* => :product)

        def product(other)
          Product.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Product
  end # module Algebra
end # module Veritas
