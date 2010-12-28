module Veritas

  # A mixin to allow instances to be visited
  module Visitable

    # Accept a visitor and dispatch the object to the visitor
    #
    # @param [#visit] visitor
    #   the visitor object
    #
    # @return [self]
    #
    # @api public
    def accept(visitor)
      visitor.visit(self)
      self
    end

  end # module Visitable
end # module Veritas
