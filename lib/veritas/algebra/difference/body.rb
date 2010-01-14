module Veritas
  module Algebra
    class Difference
      class Body < Relation::Body
        include Relation::Operation::Binary

        def header
          @header ||= left.header
        end

        def each
          right_set = right.to_set
          left.each { |tuple| yield(tuple) unless right_set.include?(tuple) }
          self
        end

      end # class Body
    end # class Difference
  end # module Algebra
end # module Veritas
