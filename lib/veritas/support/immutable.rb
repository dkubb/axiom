module Veritas
  module Immutable
    def self.included(descendant)
      descendant.extend ModuleMethods if descendant.kind_of?(Module)
      descendant.extend ClassMethods  if descendant.kind_of?(Class)
      self
    end

    # a noop when there are no memoized methods
    def memoize(name, value)
      self
    end

    def dup
      self
    end

    def self.freeze_object(object)
      case object
        when Numeric, TrueClass, FalseClass, NilClass
          object
        else
          freeze_value(object)
      end
    end

    def self.freeze_value(value)
      value.frozen? ? value : value.dup.freeze
    end

    private_class_method :freeze_value

    module ModuleMethods
      def included(mod)
        Immutable.included(mod)
        self
      end

      def memoize(*methods)
        include_memoize_methods
        methods.each { |method| memoize_method(method) }
        self
      end

    private

      def include_memoize_methods
        include MemoizeMethods unless include?(MemoizeMethods)
      end

      def memoize_method(method)
        alias_name = "__memoized_#{method}"
        create_alias_for(method, alias_name)
        create_memoize_method_for(method, alias_name)
      end

      def create_alias_for(method, alias_name)
        alias_method alias_name, method
        private alias_name
      end

      def create_memoize_method_for(method, alias_name)
        visibility = method_visibility(method)
        class_eval <<-RUBY, __FILE__, __LINE__ + 1
          def #{method}(*args)                                # def name(*args)
            @__memory['@#{method}'] ||= #{alias_name}(*args)  #   @__memory['@name'] ||= __memoized_name(*args)
          end                                                 # end
        RUBY
        send(visibility, method)
      end

      def method_visibility(method)
        if    private_method_defined?(method)   then 'private'
        elsif protected_method_defined?(method) then 'protected'
        else                                         'public'
        end
      end

    end # module ModuleMethods

    module ClassMethods
      def new(*)
        super.freeze
      end

    end # module ClassMethods

    module MemoizeMethods
      def freeze
        @__memory = Memory.new unless frozen?
        super
      end

      def memoized(name)
        @__memory["@#{name}"]
      end

      def memoize(name, value)
        @__memory["@#{name}"] = value
        self
      end

    end # module MemoizeMethods

    class Memory
      alias [] instance_variable_get

      def []=(ivar, value)
        instance_variable_set(ivar, Immutable.freeze_object(value))
      end

    end # class Memory
  end # module Immutable
end # module Veritas
