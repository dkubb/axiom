require 'veritas/attribute/comparable_attribute'

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
    include AbstractClass
    include Comparable

    attr_reader :name

    def initialize(name, options = {})
      @name     = name.to_sym
      @required = options.fetch(:required, true)
    end

    def rename(name)
      self.class.new(name)
    end

    def required?
      @required
    end

    def <=>(other)
      other = Attribute.coerce(other)
      name.to_s <=> other.name.to_s
    end

    def eql?(other)
      instance_of?(other.class) &&
      name.eql?(other.name)
    end

    def hash
      @hash ||= name.hash
    end

    def inspect
      "<#{self.class.name.gsub('Veritas::', '')} name: #{name}>"
    end

    def self.coerce(object)
      if object.kind_of?(self)
        object
      else
        name, type = object
        const_get(type.name.to_sym).new(name)
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

  end # class Attribute
end # module Veritas
