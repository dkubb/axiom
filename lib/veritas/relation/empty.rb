module Veritas
  class Relation
    class Empty < Materialized
      include Optimizable  # for no-op #optimize

      ZERO_TUPLE = [].freeze

      def initialize(header)
        super(header, ZERO_TUPLE)
      end

    end # class Empty
  end # class Relation
end # module Veritas
