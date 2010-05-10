module Veritas
  module Aliasable
    def inheritable_alias(aliases)
      aliases.each do |new_method, original_method|
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{new_method}(*args, &block)
            self.#{original_method}(*args, &block)
          end
        RUBY
      end
      self
    end

  end # module Aliasable
end # module Veritas
