module Veritas
  module Algebra
    class Intersection
      class Body < Relation::Body
        include Relation::Operation::Binary

        def header
          @header ||= left.header
        end

        def each
          right_set = right.to_set
          left.each { |tuple| yield(tuple) if right_set.include?(tuple) }
          self
        end

      end # class Body
    end # class Intersection
  end # module Algebra
end # module Veritas
