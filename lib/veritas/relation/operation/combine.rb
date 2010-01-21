module Veritas
  class Relation
    module Operation
      module Combine
        include Binary

        def self.combine_tuples(header, left_tuple, right_tuples)
          right_tuples.each do |right_tuple|
            yield Tuple.new(header, left_tuple.to_ary + right_tuple.to_ary)
          end
        end

        def optimize
          left, right = self.left.optimize, self.right.optimize

          if left.kind_of?(Relation::Empty) || right.kind_of?(Relation::Empty)
            new_empty_relation
          else
            super
          end
        end

      end # module Combine
    end # module Operation
  end # class Relation
end # module Veritas
