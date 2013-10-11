# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing a nested relation
      class Nest < Relation
        include Unary
        include Equalizer.new(:operand, :attribute)

        # The nested attribute
        #
        # @return [Attribute::Relation]
        #
        # @api private
        attr_reader :attribute

        # Initialize a nested relation
        #
        # @param [Relation] operand
        # @param [#to_sym] name
        # @param [Enumerable<Axiom::Attribute>] attributes
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operand, name, attributes)
          super(operand)
          inner      = header.project(attributes)
          @outer     = header - inner
          @attribute = Attribute::Relation.new(name, header: inner)
          @header    = @outer.extend(attribute)
        end

        # Iterate over each tuple in the set
        #
        # @example
        #   nested = Nest.new(left, right)
        #   nested.each { |tuple| ... }
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
          build_index.each do |outer_tuple, inner_tuples|
            yield outer_tuple.extend(
              header,
              [attribute.new_relation(inner_tuples)]
            )
          end
          self
        end

      private

        # Build an index using every tuple in the operand
        #
        # @return [Index]
        #
        # @api private
        def build_index
          Index.new(@outer, @attribute.header).merge(operand)
        end

        module Methods

          # Return a nested relation
          #
          # @example
          #   nested = relation.nest(:location, [:latitude, :longitude])
          #
          # @param [#to_sym] name
          # @param [Enumerable<Axiom::Attribute>] attributes
          #
          # @return [Nest]
          #
          # @api public
          def nest(name, attributes)
            Nest.new(self, name, attributes)
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Nest
    end # module Operation
  end # class Relation
end # module Axiom
