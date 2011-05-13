# encoding: utf-8

module Veritas
  class Attribute

    # A mixin for attributes that have orderable values
    module Orderable

      # Sort the attribute in ascending order
      #
      # @example
      #   ascending = attribute.asc
      #
      # @return [Relation::Operation::Order::Ascending]
      #
      # @api public
      def asc
        Relation::Operation::Order::Ascending.new(self)
      end

      # Sort the attribute in descending order
      #
      # @example
      #   descending = attribute.desc
      #
      # @return [Relation::Operation::Order::Descending]
      #
      # @api public
      def desc
        Relation::Operation::Order::Descending.new(self)
      end

    end # module Orderable
  end #class Attribute
end # module Veritas
