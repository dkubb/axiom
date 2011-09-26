# encoding: utf-8

module Veritas

  # A mixin to allow inheritable aliases for methods to be added
  module Aliasable

    # Create aliases for each specified method
    #
    # @example
    #   inheritable_alias(:- => :difference)
    #
    # @param [Hash{Symbol => Symbol}] aliases
    #   the new and old methods to alias
    #
    # @return [self]
    #
    # @api public
    def inheritable_alias(aliases)
      aliases.each { |methods| define_inheritable_alias_method(*methods) }
      self
    end

  private

    # Create a new method alias for the original method
    #
    # @param [Symbol] new_method
    #
    # @param [Symbol] original_method
    #
    # @return [undefined]
    #
    # @api private
    def define_inheritable_alias_method(new_method, original_method)
      class_eval <<-RUBY, __FILE__, __LINE__ + 1
        def #{new_method}(*args, &block)          # def |(*args, &block)
          self.#{original_method}(*args, &block)  #   self.union(*args, &block)
        end                                       # end
      RUBY
    end

  end # module Aliasable
end # module Veritas
