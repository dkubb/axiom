module Veritas
  class Attribute
    class String < Object
      extend Forwardable
      include Orderable

      def_delegator :self, :length, :range

      attr_reader :length

      def initialize(name, options = {})
        super
        @length = options.fetch(:length, 0..50).to_inclusive
      end

      def joinable?(other)
        super && length.overlaps?(other.length)
      end

      def valid_value?(value)
        validate(value) { super && length.include?(value.length) }
      end

      def match(regexp)
        Algebra::Restriction::Match.new(self, regexp)
      end

      def self.primitive
        ::String
      end

    end # class String
  end # class Attribute
end # module Veritas
