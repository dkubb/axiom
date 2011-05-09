module Veritas
  class Attribute

    # Represents an Object value in a relation tuple
    class Object < Attribute
      include Logic::Predicate::Equality::Methods,
              Logic::Predicate::Exclusion::Methods,
              Logic::Predicate::Inequality::Methods,
              Logic::Predicate::Inclusion::Methods,
              Aggregate::Count::Methods

      # The Object primitive
      #
      # @example
      #   Object.primitive  # => ::Object
      #
      # @return [Class<::Object>]
      #
      # @api public
      def self.primitive
        ::Object
      end

    end # class Object
  end # class Attribute
end # module Veritas
