module Veritas
  class Relation
    module Operation
      module Combine
        include Binary

        def self.combine_tuples(header, left_tuples, right_tuple)
          left_tuples.map { |left_tuple| yield(Tuple.new(header, left_tuple.to_ary + right_tuple.to_ary)) }
        end

      end # module Combine
    end # module Operation
  end # class Relation
end # module Veritas
