# encoding: utf-8

module Axiom

  # Define equality, equivalence and inspection methods
  class Equalizer < ::Equalizer

    # Hook called when module is included
    #
    # @param [Module] descendant
    #   the module or class including Equalizer
    #
    # @return [self]
    #
    # @api private
    def included(descendant)
      super
      descendant.module_eval do
        include Adamantium
        memoize :hash
      end
    end

    private :included

  end # class Equalizer
end # module Axiom
