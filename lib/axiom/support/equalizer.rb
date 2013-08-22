# encoding: utf-8

module Axiom

  # Define equality, equivalence and inspection methods
  class Equalizer < ::Equalizer

    # Include the #eql? and #== methods
    #
    # @return [undefined]
    #
    # @api private
    #
    # TODO: this monkey-patches equalizer and should be removed
    def initialize(*keys)
      @keys = keys
      define_methods
      include_comparison_methods

      module_eval do
        include Adamantium
        memoize :hash
      end

      freeze
    end

  end # class Equalizer
end # module Axiom
