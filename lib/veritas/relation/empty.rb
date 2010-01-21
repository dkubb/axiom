module Veritas
  class Relation
    class Empty < Relation
      def initialize(header)
        super(header, [])
      end

    end # class Empty
  end # class Relation
end # module Veritas
