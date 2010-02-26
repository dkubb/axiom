module Veritas
  class Relation
    class Empty < Relation
      include Optimizable  # for no-op #optimize

      def initialize(header)
        super(header, Set[])
      end

      def predicate
        @predicate ||= Algebra::Restriction::False.instance
      end

    end # class Empty
  end # class Relation
end # module Veritas
