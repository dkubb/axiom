module Veritas
  class Attribute
    class Numeric < Object
      extend Aliasable
      include Comparable

      inheritable_alias(:range => :size)

      attr_reader :size

      def initialize(name, options = {})
        super
        @size = options.fetch(:size, 0..2**31-1).to_inclusive
      end

      def joinable?(other)
        super && size.overlaps?(other.size)
      end

      def valid_value?(value)
        validate(value) { super && size.include?(value) }
      end

      def self.primitive
        ::Numeric
      end

    end # class Numeric
  end # class Attribute
end # module Veritas
