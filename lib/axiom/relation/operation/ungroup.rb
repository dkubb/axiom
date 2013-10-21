# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A class representing an ungrouped relation
      class Ungroup < Relation
        include Unary
        include Equalizer.new(:operand, :attribute)

        # The grouped attribute
        #
        # @return [Attribute::Relation]
        #
        # @api private
        attr_reader :attribute

        # Initialize an ungrouped relation
        #
        # @param [Relation] operand
        # @param [#to_sym] name
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
        #   ungrouped = Ungroup.new(operand, name)
        #   ungrouped.each { |tuple| ... }
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
            tuple[attribute].each do |inner_tuple|
              yield outer_tuple.extend(header, inner_tuple.to_ary)
            end
          end
          self
        end

        module Methods

          # Return an ungrouped relation
          #
          # @example
          #   ungrouped = relation.ungroup(:location, :names)
          #
          # @param [Enumerable<#to_sym>] names
          #
          # @return [Ungroup]
          #
          # @api public
          def ungroup(*names)
            names.reduce(self, &Ungroup.method(:new))
          end

        end # module Methods

        Relation.class_eval { include Methods }

      end # class Ungroup
    end # module Operation
  end # class Relation
end # module Axiom
