# encoding: utf-8

module Axiom
  class Attribute

    # A mixin for attributes that have comparable values
    module ValueComparable
      include Comparable,
              Aggregate::Minimum::Methods,
              Aggregate::Maximum::Methods,
              Aggregate::Mean::Methods,
              Aggregate::Variance::Methods,
              Aggregate::StandardDeviation::Methods

      # Initialize a value comparable attribute
      #
      # @param [#to_sym] _name
      #   the attribute name
      # @param [#to_hash] options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [Range<::Numeric>] :size
      #   The numeric range for a valid value
      #
      # @return [undefined]
      #
      # @api private
      def initialize(_name, options = EMPTY_HASH)
        super
        size = options[:size]
        return unless size
        @type = type.new do
          minimum(size.first)
          maximum(size.last)
        end
      end

    end # module ValueComparable
  end # class Attribute
end # module Axiom
