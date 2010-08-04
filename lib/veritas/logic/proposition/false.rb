module Veritas
  module Logic
    class Proposition
      class False < Proposition
        def self.complement
          True
        end

        def self.eval
          false
        end

        def and(other)
          self
        end

        def or(other)
          other
        end

      end # class False
    end # class Proposition
  end # module Algebra
end # module Veritas
