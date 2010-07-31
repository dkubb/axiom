module Veritas
  class Relation
    class Empty < Materialized
      include Optimizable  # for no-op #optimize

      def initialize(header)
        super(header, Set.new)
        @predicate = Logic::Proposition::False.instance
      end

    end # class Empty
  end # class Relation
end # module Veritas
