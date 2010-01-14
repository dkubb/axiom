module Veritas
  module Algebra
    class Join < Relation
      include Relation::Operation::Combine

      def self.new(left, right)
        if (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must have common attributes for #{name}.new"
        end

        super
      end

      def each(&block)
        index = left_index

        right.each do |tuple|
          left_tuples = index[project_join_tuple(tuple)]
          next unless left_tuples

          Relation::Operation::Combine.combine_tuples(
            header,
            left_tuples,
            project_remainder_tuple(tuple),
            &block
          )
        end

        self
      end

    private

      def left_index
        index = {}

        left.each do |tuple|
          (index[project_join_tuple(tuple)] ||= []) << tuple
        end

        index
      end

      def project_join_tuple(tuple)
        tuple.project(join_header)
      end

      def project_remainder_tuple(tuple)
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
