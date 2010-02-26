module Veritas
  module Algebra
    class Restriction
      class Proposition
        include Expression

        def self.new(*args)
          if args.empty?
            super
          else
            (args.first ? True : False).instance
          end
        end

        def call(*)
          self.class.eval
        end

        def eql?(other)
          instance_of?(other.class)
        end

        def inspect
          call.inspect
        end

        def hash
          @hash ||= call.hash
        end

      end # class Proposition

      class True < Proposition
        include Singleton

        def self.eval
          true
        end

        def and(other)
          other
        end

        def or(other)
          self
        end

        def invert
          False.instance
        end

      end # class True

      class False < Proposition
        include Singleton

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
    end # class Restriction
  end # module Algebra
end # module Veritas
