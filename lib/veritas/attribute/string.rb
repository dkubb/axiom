module Veritas
  class Attribute
    class String < Object
      extend Aliasable
      include Orderable,
              Logic::Predicate::Match::Methods,
              Logic::Predicate::NoMatch::Methods

      DEFAULT_LENGTH = (0..50).freeze

      inheritable_alias(:range => :length)

      attr_reader :length

      def self.primitive
        ::String
      end

      def initialize(*)
        super
        @length = @options.fetch(:length, DEFAULT_LENGTH).to_inclusive
      end

      def joinable?(other)
        super && length.eql?(other.length)
      end

      def valid_value?(value)
        valid_or_optional?(value) { super && length.include?(value.length) }
      end

    end # class String
  end # class Attribute
end # module Veritas
