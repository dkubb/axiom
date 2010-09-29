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
      aliases.each do |new_method, original_method|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{new_method}(*args, &block)          # def |(*args, &block)
            self.#{original_method}(*args, &block)  #   self.union(*args, &block)
          end                                       # end
        RUBY
      end
      self
    end

  end # module Aliasable
end # module Veritas
