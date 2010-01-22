module Veritas
  module Algebra
    class Join < Relation
      include Relation::Operation::Combine

      def self.new(left, right)
        left_header, right_header = left.header, right.header
        if (left_header & right_header).empty?
          raise InvalidHeaderError, "the headers must have common attributes for #{name}.new"
        elsif left_header == right_header
          raise InvalidHeaderError, 'the headers are identical, use intersection instead'
        end

        super
      end

      def each(&block)
        index = build_index

        left.each do |tuple|
          right_tuples = index[join_tuple(tuple)]
          if right_tuples
            Relation::Operation::Combine.combine_tuples(header, tuple, right_tuples, &block)
          end
        end

        self
      end

    private

      def build_index
        index = {}

        right.each do |tuple|
          (index[join_tuple(tuple)] ||= Set[]) << remainder_tuple(tuple)
        end

        index
      end

      def join_tuple(tuple)
        tuple.project(join_header)
      end

      def remainder_tuple(tuple)
        tuple.project(remainder_header)
      end

      def join_header
        @join_header ||= left.header & right.header
      end

      def remainder_header
        @remainder_header ||= right.header - join_header
      end

    end # class Join
  end # module Algebra
end # module Veritas
