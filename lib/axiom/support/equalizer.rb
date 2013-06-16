# encoding: utf-8

module Axiom

  # Define equality, equivalence and inspection methods
  class Equalizer < ::Equalizer

    # Include the #eql? and #== methods
    #
    # @return [undefined]
    #
    # @api private
    def initialize(*)
      super
      module_eval do
        include Adamantium::Flat
        memoize :hash
      end
    end

  end # class Equalizer
end # module Axiom
