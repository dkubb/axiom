module Veritas
  module Immutable
    def self.included(descendant)
      descendant.extend ModuleMethods if descendant.kind_of?(Module)
      descendant.extend ClassMethods  if descendant.kind_of?(Class)
      self
    end

    def dup
      self
    end

    module ModuleMethods
      def included(mod)
        Immutable.included(mod)
      end

      def memoize(*methods)
        include_memoize_methods
        methods.each do |method|
          memoized_method = "__memoized_#{method}"
          alias_private_method(memoized_method, method)
          create_memoize_method_for(memoized_method, method)
        end
        self
      end

    private

      def include_memoize_methods
        include MemoizeMethods unless include?(MemoizeMethods)
      end

      def alias_private_method(new_method, old_method)
        alias_method new_method, old_method
        private new_method
      end

      def create_memoize_method_for(memoized_method, method)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{method}                                     # def name
            @__memory['@#{method}'] ||= #{memoized_method}  #   @__memory['@name'] ||= name
          end                                               # end
          #{method_visibility(method)} :#{method}           # private :name
        RUBY
      end

      def method_visibility(method)
        if    private_method_defined?(method)   then 'private'
        elsif protected_method_defined?(method) then 'protected'
        end
      end

    end # module ModuleMethods

    module ClassMethods
      def new(*args)
        super.freeze
      end

    end # module ClassMethods

    module MemoizeMethods
      def freeze
        @__memory = Memory.new unless frozen?
        super
      end

      def memoize(name, value)
        @__memory["@#{name}"] = value
        self
      end

    end # module MemoizeMethods

    class Memory
      extend Aliasable

      inheritable_alias(:[] => :instance_variable_get)

      def []=(key, value)
        instance_variable_set(key, self.class.memoized_value(value))
      end

      def self.memoized_value(value)
        case value
          when Numeric, TrueClass, FalseClass, NilClass
            value
          else
            value.frozen? ? value : value.dup.freeze
        end
      end

    end # class Memory
  end # module Immutable
end # module Veritas
