# encoding: utf-8

module Axiom
  class Attribute

    # Represents a String value in a relation tuple
    class String < Object
      include Comparable,
              Function::Predicate::Match::Methods,
              Function::Predicate::NoMatch::Methods

      # The attribute type
      #
      # @example
      #   type = Axiom::Attribute::String.type  # => Axiom::Types::String
      #
      # @return [Class<Types::String>]
      #
      # @api public
      def self.type
        Types::String
      end

      # Initialize a String Attribute
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
        if min || max
          @type = type.new do
            minimum_length(min) if min
            maximum_length(max) if max
          end
        end
      end

    end # class String
  end # class Attribute
end # module Axiom
