module Veritas
  module Algebra
    class Join < Relation
      include CombineOperation

      def self.new(left, right)
        if (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must have common attributes for #{name}.new"
        end

        super
      end

    private

      def combine_bodies
        body = []

        index = left_index

        right.each do |right_tuple|
          left_tuples = index[right_tuple.project(common_header)]
          next unless left_tuples

          join_tuple = right_tuple.project(remainder_header)
          body.concat self.class.combine_tuples(left_tuples, join_tuple)
        end

        body
      end

      def common_header
        @common_header ||= left.header & right.header
      end

      def remainder_header
        @remainder_header ||= right.header - common_header
      end

      def left_index
        index = {}

        left.each do |left_tuple|
          (index[left_tuple.project(common_header)] ||= []) << left_tuple
        end

        index
      end

    end # class Join
  end # module Algebra
end # module Veritas
