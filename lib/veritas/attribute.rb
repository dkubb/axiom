module Veritas
  class Attribute
    include Comparable

    attr_reader :name, :type

    def initialize(name, type)
      @name, @type = name.to_sym, type
    end

    def <=>(other)
      other = self.class.coerce(other)
      [ name.to_s, type ] <=> [ other.name.to_s, other.type ]
    end

    def eql?(other)
      instance_of?(other.class) &&
      name.eql?(other.name) &&
      type.eql?(other.type)
    end

    def hash
      name.hash ^ type.hash
    end

    def self.coerce(attribute)
      if Attribute === attribute
        attribute
      elsif attribute.respond_to?(:to_ary)
        new(*attribute)
      else
        raise ArgumentError, "object must be either #{self} or respond to #to_ary, but was #{attribute.class}"
      end
    end
  end
end
