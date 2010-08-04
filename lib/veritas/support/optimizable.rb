module Veritas
  module Optimizable
    def optimize
      self
    end

    def optimized?
      equal?(optimize)
    end

  end # module Optimizable
end # module Veritas
