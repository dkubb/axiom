module Veritas
  class Relation
    module Operation
      module Binary
        attr_reader :left, :right

        def initialize(left, right)
          @left, @right = left, right
        end

        def header
          @header ||= left.header | right.header
        end

      end # module Binary
    end # module Operation
  end # class Relation
end # module Veritas
