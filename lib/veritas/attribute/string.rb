module Veritas
  class Attribute
    class String < Object
      include Comparable

      attr_reader :length

      def initialize(name, options = {})
        super
        @length = options.fetch(:length, 0..50)
      end

      def match(regexp)
        Algebra::Restriction::Match.new(self, regexp)
      end
    end # class String
  end # class Attribute
end # module Veritas
