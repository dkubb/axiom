module Veritas
  module Logic
    class Predicate
      class NoMatch < Predicate
        def self.eval(left, right)
          !(right === left)
        end

        def inspect
          "#{left.inspect} !~ #{right.inspect}"
        end

        module Methods
          def no_match(regexp)
            Logic::Predicate::NoMatch.new(self, regexp)
          end

        end # module Methods
      end # class NoMatch
    end # class Predicate
  end # module Logic
end # module Veritas
