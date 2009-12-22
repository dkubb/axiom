module Veritas
  module Algebra
    module CombineOperation
      include BinaryOperation

      def header
        @header ||= left.header | right.header
      end

      def body
        @body ||= combine_bodies
      end

    private

      def combine_bodies
        raise NotImplementedError, "#{self.class.name}#combine_bodies must be implemented"
      end
    end # module BinaryOperation
  end # module Algebra
end # module Veritas
