require 'veritas/attribute/comparable_attribute'

require 'veritas/attribute/object'
require 'veritas/attribute/numeric'

require 'veritas/attribute/boolean'
require 'veritas/attribute/string'
require 'veritas/attribute/text'
require 'veritas/attribute/binary'
require 'veritas/attribute/float'
require 'veritas/attribute/integer'
require 'veritas/attribute/decimal'
require 'veritas/attribute/date_time'
require 'veritas/attribute/date'
require 'veritas/attribute/time'
require 'veritas/attribute/class'

module Veritas
  class Attribute
    include AbstractClass
    include Comparable

    attr_reader :name

    def initialize(name)
      @name = name.to_sym
    end

    def rename(name)
      self.class.new(name)
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
