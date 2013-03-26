# encoding: utf-8

module Axiom

  # A mixin to allow instances to be visited
  module Visitable

    # Accept a visitor and dispatch the object to the visitor
    #
    # @example
    #   visitable = visitable.accept(visitor)
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
end # module Axiom
