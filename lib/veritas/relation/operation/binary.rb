# encoding: utf-8

module Veritas
  class Relation
    module Operation

      # A mixin for Binary relations
      module Binary
        include Veritas::Operation::Binary

        # Hook called when module is included
        #
        # @param [Module] descendant
        #   the module or class including Binary
        #
        # @return [self]
        #
        # @api private
        def self.included(descendant)
          super
          descendant.extend ClassMethods
          self
        end

        # Initialize a Binary relation
        #
        # @param [Relation] left
        # @param [Relation] right
        #
        # @return [undefined]
        #
        # @api private
        def initialize(left, right)
          super
          @header = left.header | right.header
        end

        module ClassMethods

          # Instantiate a new Binary relation
          #
          # @example
          #   binary = BinaryRelation.new(left, right)
          #
          # @param [Relation] left
          # @param [Relation] right
          #
          # @return [Binary]
          #
          # @api public
          def new(left, right)
            assert_ordered_match(left, right)
            super
          end

        private

          # Assert that ordered and unordered relations are not mixed
          #
          # @param [Relation] left
          # @param [Relation] right
          #
          # @return [undefined]
          #
          # @raise [RelationMismatchError]
          #   raised if one relation is ordered and the other is not
          #
          # @api private
          def assert_ordered_match(left, right)
            if left.directions.empty? != right.directions.empty?
              raise RelationMismatchError, 'both relations must be ordered or neither may be ordered'
            end
          end

        end # module ClassMethods
      end # module Binary
    end # module Operation
  end # class Relation
end # module Veritas
