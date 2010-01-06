module Veritas
  class Attribute
    class String < Object
      def match(regexp)
        Algebra::Restriction::Match.new(self, regexp)
      end
    end # class String
  end # class Attribute
end # module Veritas
