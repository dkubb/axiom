# encoding: utf-8

module Axiom
  class Attribute

    # A mixin for attributes that have comparable lengths
    module LengthComparable
      include Comparable

      # Initialize a length comparable attribute
      #
      # @param [#to_sym] _name
      #   the attribute name
      # @param [#to_hash] options
      #   the options for the attribute
      # @option options [Boolean] :required (true)
      #   if true, then the value cannot be nil
      # @option options [::Integer] :minimum_length
      #   The minimum string length for a valid value
      # @option options [::Integer] :maximum_length
      #   The maximum string length for a valid value
      #
      # @return [undefined]
      #
      # @api private
      def initialize(_name, options = EMPTY_HASH)
        super
        min, max = options.values_at(:minimum_length, :maximum_length)
        return unless min || max
        @type = type.new do
          minimum_length(min) if min
          maximum_length(max) if max
        end
      end

    end # module LengthComparable
  end # class Attribute
end # module Axiom
