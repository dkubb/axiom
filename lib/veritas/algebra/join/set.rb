module Veritas
  module Algebra
    class Join
      class Set
        def initialize(left, right)
          @left, @right = left, right
        end

        def each(&block)
          index = left_index

          @right.each do |tuple|
            left_tuples = index[project_join_tuple(tuple)]
            next unless left_tuples

            CombineOperation.combine_tuples(
              left_tuples,
              project_right_tuple(tuple),
              &block
            )
          end

          self
        end

      private

        def project_join_tuple(tuple)
          tuple.project(join_header)
        end

        def project_right_tuple(tuple)
          tuple.project(remainder_header)
        end

        def join_header
          @join_header ||= @left.header & @right.header
        end

        def remainder_header
          @remainder_header ||= @right.header - join_header
        end

        def left_index
          index = {}

          @left.each do |tuple|
            (index[project_join_tuple(tuple)] ||= []) << tuple
          end

          index
        end

      end # class Set
    end # class Join
  end # module Algebra
end # module Veritas
