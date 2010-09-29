module Veritas
  class Attribute
    class Numeric < Object
      extend Aliasable
      include Comparable

      DEFAULT_SIZE = (0..2**31-1).freeze

      inheritable_alias(:range => :size)

      attr_reader :size

      def self.primitive
        ::Numeric
      end

      def initialize(*)
        super
        @size = @options.fetch(:size, DEFAULT_SIZE).to_inclusive
      end

      def joinable?(other)
        super && size.eql?(other.size)
      end

      def valid_value?(value)
        valid_or_optional?(value) { super && size.include?(value) }
      end

    end # class Numeric
  end # class Attribute
end # module Veritas
