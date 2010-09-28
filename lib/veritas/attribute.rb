require 'veritas/attribute/orderable'

require 'veritas/attribute/comparable'

require 'veritas/attribute/object'
require 'veritas/attribute/numeric'

require 'veritas/attribute/boolean'
require 'veritas/attribute/class'
require 'veritas/attribute/date'
require 'veritas/attribute/date_time'
require 'veritas/attribute/decimal'
require 'veritas/attribute/float'
require 'veritas/attribute/integer'
require 'veritas/attribute/time'
require 'veritas/attribute/string'

module Veritas
  class Attribute
    include AbstractClass, Immutable, ::Comparable

    attr_reader :name, :options

    def initialize(name, options = {})
      @name     = name.to_sym
      @options  = Immutable.freeze_object(options)
      @required = @options.fetch(:required, true)
    end

    def call(tuple)
      tuple[self]
    end

    def rename(new_name)
      name.equal?(new_name) ? self : self.class.new(new_name, options)
    end

    def required?
      @required
    end

    def valid_primitive?(value)
      self.class.primitive === value
    end

    def valid_value?(value)
      validate(value) { valid_primitive?(value) }
    end

    def joinable?(other)
      kind_of?(other.class) || other.kind_of?(self.class)
    end

    def <=>(other)
      other = Attribute.coerce(other)
      name.to_s <=> other.name.to_s
    end

    def eql?(other)
      instance_of?(other.class) &&
      name.equal?(other.name)   &&
      options.eql?(other.options)
    end

    def hash
      name.hash ^ options.hash
    end

    def inspect
      "<#{self.class.name.gsub('Veritas::', '')} name: #{name}>"
    end

    def self.coerce(object)
      if object.kind_of?(self)
        object
      else
        name, type = object
        klass = type.nil? ? Object : const_get(type.name)
        klass.new(name)
      end
    end

    def self.name_from(attribute)
      if attribute.kind_of?(self)
        attribute.name
      elsif attribute.respond_to?(:to_ary)
        attribute.to_ary.first
      else
        attribute.to_sym
      end
    end

  private

    def validate(value)
      value.nil? ? !required? : yield
    end

    memoize :hash

  end # class Attribute
end # module Veritas
