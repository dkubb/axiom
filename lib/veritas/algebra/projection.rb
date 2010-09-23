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

      module Methods

        # Return a relation with only the attributes specified
        #
        # @example
        #   projection = relation.project([ :a, b, c ])
        #
        # @param [#to_ary] attributes
        #   the attributes to keep in the header
        #
        # @return [Projection]
        #   a relation containing only the specified attributes
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
        #   a relation containing everything except the specified attributes
        #
        # @api public
        def remove(attributes)
          project(header - project_header(attributes))
        end

      private

        def project_header(attributes)
          header.project(attributes)
        end

        def project_relation(operand, attributes = header)
          Projection.new(operand, attributes)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Projection
  end # module Algebra
end # module Veritas
