module Veritas
  class Attribute
    class Float < Numeric
      def self.primitive
        ::Float
      end

    end # class Float
  end # class Attribute
end # module Veritas
