# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing a unwrapped relation
      class Unwrap < Relation
        include Unary
        include Equalizer.new(:operand, :attribute)

        # The unwrapped attribute
        #
        # @return [Attribute::Relation]
        #
        # @api private
        attr_reader :attribute

        # Initialize a unwrapped relation
        #
        # @param [Relation] operand
        # @param [#to_sym] name
        # @param [Enumerable<Axiom::Attribute>] attributes
        #
        # @return [undefined]
        #
        # @api private
        def initialize(operand, name)
          super(operand)
          @attribute = header[name]
          @outer     = header - [attribute]
          @header    = @outer.extend(attribute.header)
        end

        # Iterate over each tuple in the set
        #
        # @example
        #   unwrapped = Unwrap.new(left, right)
        #   unwrapped.each { |tuple| ... }
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
            yield tuple.project(@outer).join(header, tuple[attribute])
          end
          self
        end

        module Methods

          # Return a unwrapped relation
          #
          # @example
          #   unwrapped = relation.unwrap(:location, :names)
          #
          # @param [Enumerable<#to_sym>] names
          #
          # @return [Unwrap]
          #
          # @api public
          def unwrap(*names)
            names.reduce(self, &Unwrap.method(:new))
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Unwrap
    end # module Operation
  end # class Relation
end # module Axiom
