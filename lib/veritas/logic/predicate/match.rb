module Veritas
  module Logic
    class Predicate
      class Match < Predicate
        include Comparable

        def self.operation
          :=~
        end

        def self.inverse
          NoMatch
        end

        module Methods
          def match(regexp)
            Logic::Predicate::Match.new(self, regexp)
          end

        end # module Methods
      end # class Match
    end # class Predicate
  end # module Logic
end # module Veritas
