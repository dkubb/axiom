# encoding: utf-8

module Axiom

  # Abstract base class for logical functions
  class Function
    include AbstractType, Adamantium, Visitable

    abstract_singleton_method :call
    abstract_method :rename, :type

    # Rename the attribute(s) inside the function
    #
    # @param [Function] operand
    #
    # @param [Algebra::Rename::Aliases] aliases
    #
    # @return [Function]
    #
    # @todo simplify once Attribute#rename works the same as Function#rename
    #
    # @api private
    def self.rename_attributes(operand, aliases)
      if operand.respond_to?(:rename) && ! operand.kind_of?(Attribute)
        operand.rename(aliases)
      else
        aliases[operand]
      end
    end

    # Extract the value from the operand or tuple
    #
    # @param [Object, #call] operand
    #   the operand to extract the value from
    # @param [Tuple] tuple
    #   the tuple to pass in to the operand if it responds to #call
    #
    # @return [Object]
    #
    # @api private
    def self.extract_value(operand, tuple)
      operand.respond_to?(:call) ? operand.call(tuple) : operand
    end

  end # class Function
end # module Axiom
