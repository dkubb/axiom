# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing a wrapped relation
      class Wrap < Relation
        include Unary
        include Equalizer.new(:operand, :attribute)

        # The wrapped attribute
        #
        # @return [Attribute::Relation]
        #
        # @api private
        attr_reader :attribute

        # Initialize a wrapped relation
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
          @attribute = Attribute::Tuple.new(name, header: inner)
          @header    = @outer.extend(attribute)
        end

        # Iterate over each tuple in the set
        #
        # @example
        #   wrapped = Wrap.new(operand, name attributes)
        #   wrapped.each { |tuple| ... }
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
          operand.each do |tuple|
            outer_tuple = tuple.project(@outer)
            inner_tuple = tuple.project(attribute.header)
            yield outer_tuple.extend(header, [inner_tuple])
          end
          self
        end

        module Methods

          # Return a wrapped relation
          #
          # @example
          #   wrapped = relation.wrap(location: [:latitude, :longitude])
          #
          # @param [Hash{#to_sym => Enumerable<Axiom::Attribute>] wrapping
          #
          # @return [Wrap]
          #
          # @api public
          def wrap(wrapping)
            wrapping.reduce(self) do |operation, pair|
              Wrap.new(operation, *pair)
            end
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Wrap
    end # module Operation
  end # class Relation
end # module Axiom
