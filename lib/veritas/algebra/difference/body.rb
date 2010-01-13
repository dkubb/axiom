module Veritas
  module Algebra
    class Difference
      class Body < Relation::Body
        include BinaryOperation

        def header
          @header ||= left.header
        end

        def each
          right = right_set
          left.each { |tuple| yield(tuple) unless right.include?(tuple) }
          self
        end

      private

        def right_set
          @right_set ||= right.to_set
        end

      end # class Body
    end # class Difference
  end # module Algebra
end # module Veritas
