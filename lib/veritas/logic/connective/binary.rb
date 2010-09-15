module Veritas
  module Logic
    class Connective < Expression
      module Binary
        include Operation::Binary

        def call(tuple)
          self.class.call(left.call(tuple), right.call(tuple))
        end

        def project(attributes)
          left  = self.left.project(attributes)
          right = self.right.project(attributes)

          if left.nil?
            right
          elsif right.nil?
            left
          else
            super
          end
        end

        def rename(aliases)
          left          = self.left
          right         = self.right
          renamed_left  = left.rename(aliases)
          renamed_right = right.rename(aliases)

          if left.equal?(renamed_left) && right.equal?(renamed_right)
            self
          else
            self.class.new(renamed_left, renamed_right)
          end
        end

        def inverse
          Negation.new(self)
        end

        memoize :inverse

      end # module Binary
    end # class Connective
  end # module Logic
end # module Veritas
