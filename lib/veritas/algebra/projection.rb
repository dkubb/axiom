module Veritas
  module Algebra

    # Specify only specific attributes to keep in the relation
    class Projection < Relation
      include Relation::Operation::Unary

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
        @header     = @header.project(attributes.to_ary)
        @directions = @directions.project(@header)
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
        seen = {}
        operand.each do |tuple|
          tuple = tuple.project(header)
          yield(seen[tuple] = tuple) unless seen.key?(tuple)
        end
        self
      end

      # Compare the Projection with other relation for equality
      #
      # @example
      #   projection.eql?(other)  # => true or false
      #
      # @param [Relation] other
      #   the other relation to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        super && header.eql?(other.header)
      end

      # Return the hash of the projection
      #
      # @example
      #   hash = projection.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        super ^ header.hash
      end

      module Methods

        # Return a relation with only the attributes specified
        #
        # @example
        #   projection = relation.project([ :a, :b, :c ])
        #
        # @param [#to_ary] attributes
        #   the attributes to keep in the header
        #
        # @return [Projection]
        #
        # @api public
        def project(attributes)
          project_relation(self, attributes)
        end

        # Return a relation with attributes not specified
        #
        # @example
        #   projection = relation.remove([ :a, b, c ])
        #
        # @param [#to_ary] attributes
        #   the attributes to remove from the header
        #
        # @return [Projection]
        #
        # @api public
        def remove(attributes)
          project(header - project_header(attributes))
        end

      private

        # Return a header with only the attributes specified
        #
        # @param [#to_ary] attributes
        #   the attributes to keep in the header
        #
        # @return [Header]
        #
        # @api private
        def project_header(attributes)
          header.project(attributes)
        end

        # Return a relation with only the attribtues specified
        #
        # @param [Relation] operand
        #   the relation to project
        # @param [#to_ary] attributes
        #   optional attributes to keep in the projection
        #
        # @return [Projection]
        #
        # @api private
        def project_relation(operand, attributes = header)
          Projection.new(operand, attributes)
        end

      end # module Methods

      Relation.class_eval { include Methods }

      memoize :hash

    end # class Projection
  end # module Algebra
end # module Veritas
