# encoding: utf-8

module Veritas
  module Algebra

    # The cartesian product between relations
    class Product < Relation
      include Relation::Operation::Combination

      # Instantiate a new Product
      #
      # @example
      #   product = Product.new(left, right)
      #
      # @param [Relation] left
      # @param [Relation] right
      #
      # @return [Join]
      #
      # @api public
      def self.new(left, right)
        assert_disjointed_headers(left, right)
        super
      end

      # Assert the headers do not have common attributes
      #
      # @param [Relation] left
      # @param [Relation] right
      #
      # @return [undefined]
      #
      # @raise [InvalidHeaderError]
      #   raised if there are common attributes between the headers
      #
      # @api private
      def self.assert_disjointed_headers(left, right)
        if (left.header & right.header).any?
          raise InvalidHeaderError, 'the headers must be disjointed'
        end
      end

      private_class_method :assert_disjointed_headers

      # Iterate over each tuple in the set
      #
      # @example
      #   product = Product.new(left, right)
      #   product.each { |tuple| ... }
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the set
      #
      # @return [self]
      #
      # @api public
      def each(&block)
        return to_enum unless block_given?
        util = Relation::Operation::Combination
        left.each do |left_tuple|
          util.combine_tuples(header, left_tuple, right, &block)
        end
        self
      end

      # Raise an exception when inserting into the Product
      #
      # @example
      #   product.insert(other)  # => ImmutableRelationError raised
      #
      # @return [undefined]
      #
      # @raise [ImmutableRelationError]
      #   raised when inserting into the product
      #
      # @api public
      def insert(*)
        raise ImmutableRelationError, 'inserting into a product is impossible'
      end

      # Raise an exception when deleting from the Product
      #
      # @example
      #   product.delete(other)  # => ImmutableRelationError raised
      #
      # @return [undefined]
      #
      # @raise [ImmutableRelationError]
      #   raised when deleting from the product
      #
      # @api public
      def delete(*)
        raise ImmutableRelationError, 'deleting from a product is impossible'
      end

      module Methods
        extend Aliasable

        inheritable_alias(:* => :product)

        # Return a relation that is the cartesian product of two relations
        #
        # @example
        #   product = relation.product(other)
        #
        # @param [Relation] other
        #   the other relation to find the product with
        #
        # @return [Product]
        #
        # @api public
        def product(other)
          Product.new(self, other)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Product
  end # module Algebra
end # module Veritas
