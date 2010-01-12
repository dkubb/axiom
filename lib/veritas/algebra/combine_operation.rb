module Veritas
  module Algebra
    module CombineOperation
      include BinaryOperation

      def header
        @header ||= left.header | right.header
      end

      def body
        @body ||= Relation::Body.new(header, combine_bodies)
      end

    private

      def combine_bodies
        raise NotImplementedError, "#{self.class.name}#combine_bodies must be implemented"
      end

      def self.combine_tuples(left_tuples, right_tuple)
        left_tuples.map { |left_tuple| yield(left_tuple.to_ary + right_tuple.to_ary) }
      end

    end # module CombineOperation
  end # module Algebra
end # module Veritas
