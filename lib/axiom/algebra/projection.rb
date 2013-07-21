# encoding: utf-8

module Axiom
  module Algebra

    # Specify only specific attributes to keep in the relation
    class Projection < Relation
      include Relation::Operation::Unary
      include Equalizer.new(:operand, :header)

      # Initialize a Projection
      #
      # @param [Relation] operand
      #   the relation to project
      # @param [#to_ary] attributes
      #   the attributes to keep in the header
      #
      # @return [undefined]
      #
      # @api private
      def initialize(operand, attributes)
        super(operand)
        @header = @header.project(attributes)
      end

      # Iterate over each tuple in the set
      #
      # @example
      #   projection = Projection.new(operand, attributes)
      #   projection.each { |tuple| ... }
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the set
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        seen = {}
        operand.each do |tuple|
          tuple = tuple.project(header)
          yield seen[tuple] = tuple unless seen.key?(tuple)
        end
        self
      end

      # Insert a relation into the Projection
      #
      # @example
      #   new_relation = projection.insert(other)
      #
      # @param [Relation] other
      #
      # @return [Projection]
      #
      # @raise [RequiredAttributesError]
      #   raised when inserting into a relation with required attributes removed
      #
      # @raise [InvalidHeaderError]
      #   raised if the headers are not equivalent
      #
      # @api public
      def insert(other)
        other = coerce(other)
        assert_removed_attributes_optional
        assert_equivalent_headers(other)
        operand.insert(extend_other(other)).project(header)
      end

      # Delete a relation from the Projection
      #
      # @example
      #   new_relation = projection.delete(other)
      #
      # @param [Relation] other
      #
      # @return [Projection]
      #
      # @raise [InvalidHeaderError]
      #   raised if the headers are not equivalent
      #
      # @api public
      def delete(other)
        other = coerce(other)
        assert_equivalent_headers(other)
        operand.delete(extend_other(other)).project(header)
      end

    private

      # Assert that removed attributes are optional
      #
      # @return [undefined]
      #
      # @raise [RequiredAttributesError]
      #   raised when inserting into a relation with required attributes removed
      #
      # @api private
      def assert_removed_attributes_optional
        names = required_attribute_names
        if names.any?
          raise RequiredAttributesError, "required attributes #{names.inspect} have been removed"
        end
      end

      # Assert that other relation header is equivalent
      #
      # @param [Relation] other
      #
      # @return [undefined]
      #
      # @raise [InvalidHeaderError]
      #   raised if the headers are not equivalent
      #
      # @api private
      def assert_equivalent_headers(other)
        if header != other.header
          raise InvalidHeaderError, 'the headers must be equivalent'
        end
      end

      # Names of the required attributes that were removed
      #
      # @return [Array<Symbol>]
      #
      # @api private
      def required_attribute_names
        removed_attributes.each_with_object([]) do |attribute, names|
          names << attribute.name if attribute.required?
        end
      end

      # Attributes that were removed by the projection
      #
      # @return [Array<Attribute>]
      #
      # @api private
      def removed_attributes
        operand.header - header
      end

      # Extend the other relation with removed attributes
      #
      # @param [Relation] other
      #
      # @return [Extension]
      #
      # @api private
      def extend_other(other)
        other.extend(Hash[removed_attributes.zip])
      end

      module Methods

        # Return a relation with only the attributes specified
        #
        # @example
        #   projection = relation.project([:a, :b, :c])
        #
        # @param [#to_ary] attributes
        #   the attributes to keep in the header
        #
        # @return [Projection]
        #
        # @api public
        def project(attributes)
          Projection.new(self, attributes)
        end

        # Return a relation with attributes not specified
        #
        # @example
        #   projection = relation.remove([:a, b, c])
        #
        # @param [#to_ary] attributes
        #   the attributes to remove from the header
        #
        # @return [Projection]
        #
        # @api public
        def remove(attributes)
          project(header - attributes)
        end

      end # module Methods

      Relation.class_eval { include Methods }

      memoize :removed_attributes

    end # class Projection
  end # module Algebra
end # module Axiom
