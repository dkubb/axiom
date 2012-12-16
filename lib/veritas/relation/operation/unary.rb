# encoding: utf-8

module Veritas
  class Relation
    module Operation

      # A mixin for Unary relations
      module Unary
        include Veritas::Operation::Unary

        # Initialize a Unary relation
        #
        # @return [undefined]
        #
        # @api private
        def initialize(*)
          super
          @header = operand.header
        end

      end # module Unary
    end # module Operation
  end # class Relation
end # module Veritas
