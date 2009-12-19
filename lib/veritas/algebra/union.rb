module Veritas
  module Algebra
    class Union < Relation
      include SetOperation

      def self.operation
        :|
      end
    end # class Union
  end # module Algebra
end # module Veritas
