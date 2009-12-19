module Veritas
  module Algebra
    class Union < Relation
      include SetOperation

      def body
        @body ||= @left.body | @right.body
      end
    end # class Union
  end # module Algebra
end # module Veritas
