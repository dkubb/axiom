module Veritas
  module Logic
    class Proposition
      class False < Proposition
        def self.eval
          false
        end

        def and(other)
          self
        end

        def or(other)
          other
        end

        def invert
          True.instance
        end

      end # class False
    end # class Proposition
  end # module Algebra
end # module Veritas
