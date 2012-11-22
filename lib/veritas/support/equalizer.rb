# encoding: utf-8

module Veritas

  # Define equality, equivalence and inspection methods
  class Equalizer < ::Equalizer

  private

    # Include the #eql? and #== methods
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

  end # class Equalizer
end # module Veritas
