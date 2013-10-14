# encoding: utf-8

module Axiom
  class Relation
    module Operation

      # A mixin for Binary relations
      module Binary
        include Axiom::Operation::Binary

        # Hook called when module is included
        #
        # @param [Module] descendant
        #   the module or class including Binary
        #
        # @return [undefined]
        #
        # @api private
        def self.included(descendant)
          super
          descendant.extend(ClassMethods)
        end

        private_class_method :included

        # Initialize a Binary relation
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
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
            assert_sorted_match(left, right)
            super
          end

        private

          # Assert that sorted and unsorted relations are not mixed
          #
          # @param [Relation] left
          # @param [Relation] right
          #
          # @return [undefined]
          #
          # @raise [RelationMismatchError]
          #   raised if one relation is sorted and the other is not
          #
          # @api private
          def assert_sorted_match(left, right)
            if left.directions.empty? != right.directions.empty?
              fail RelationMismatchError, 'both relations must be sorted or neither may be sorted'
            end
          end

        end # module ClassMethods
      end # module Binary
    end # module Operation
  end # class Relation
end # module Axiom
