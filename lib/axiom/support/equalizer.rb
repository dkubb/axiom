# encoding: utf-8

module Axiom

  # Define equality, equivalence and inspection methods
  class Equalizer < ::Equalizer

    # Include Adamanitium and memoize #hash
    #
    # @return [undefined]
    #
    # @api private
    def include_comparison_methods
      super
      module_eval do
        include Adamantium
        memoize :hash
      end
    end

    private :include_comparison_methods

  end # class Equalizer
end # module Axiom
