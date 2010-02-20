module Veritas
  class Attribute
    module Orderable
      def asc
        Relation::Operation::Order::Ascending.new(self)
      end

      def desc
        Relation::Operation::Order::Descending.new(self)
      end
    end
  end
end
