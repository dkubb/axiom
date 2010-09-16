module Veritas
  class Relation
    module Operation
      module Combine
        include Binary

        def self.combine_tuples(header, left_tuple, right_tuples)
          right_tuples.each do |right_tuple|
            yield left_tuple.join(header, right_tuple)
          end
        end

      end # module Combine
    end # module Operation
  end # class Relation
end # module Veritas
