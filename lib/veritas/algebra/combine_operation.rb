module Veritas
  module Algebra
    module CombineOperation
      include BinaryOperation

      def self.included(klass)
        klass.extend ClassMethods
      end

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

      module ClassMethods
        def combine_tuples(left_tuples, right_tuple)
          left_tuples.map { |left_tuple| left_tuple.to_ary + right_tuple.to_ary }
        end
      end

    end # module CombineOperation
  end # module Algebra
end # module Veritas
