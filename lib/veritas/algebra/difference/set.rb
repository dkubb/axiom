module Veritas
  module Algebra
    class Difference
      class Set
        def initialize(left, right)
          @left, @right = left, right
        end

        def each
          right = right_set
          @left.each { |tuple| yield(tuple) unless right.include?(tuple) }
          self
        end

      private

        def right_set
          @right_set ||= @right.to_set
        end

      end # class Set
    end # class Difference
  end # module Algebra
end # module Veritas
