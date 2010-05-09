module Veritas
  module Logic
    class Proposition
      class True < Proposition
        def self.eval
          true
        end

        def and(other)
          other
        end

        def or(other)
          self
        end

        def complement
          False.instance
        end

      end # class True
    end # class Proposition
  end # module Algebra
end # module Veritas
