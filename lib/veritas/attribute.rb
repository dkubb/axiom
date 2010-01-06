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
      [ name.to_s ] <=> [ other.name.to_s ]
    end

    def eql?(other)
      instance_of?(other.class) &&
      name.eql?(other.name)
    end

    def hash
      name.hash
    end

    def self.new(*args)
      if self == Attribute
        raise NotImplementedError, "#{self}.new is an abstract method"
      else
        super
      end
    end

    def self.coerce(attribute)
      if attribute.kind_of?(self)
        attribute
      else
        name, type = attribute
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
