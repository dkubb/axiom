module Veritas
  module Logic
    class Predicate
      class NoMatch < Predicate
        include Comparable

        def self.operation
          :'!~'
        end

        def self.complement
          Match
        end

        def self.eval(left, right)
          left !~ right
        end unless Object.method_defined?(operation)

        module Methods
          def no_match(regexp)
            Logic::Predicate::NoMatch.new(self, regexp)
          end

        end # module Methods
      end # class NoMatch
    end # class Predicate
  end # module Logic
end # module Veritas
