module Veritas
  class Tuple
    attr_reader :header

    def initialize(header, data)
      @header, @data = header, data.to_ary
    end

    def project(header)
      original = self.header
      indexes  = header.map { |attribute| original.index(attribute) }
      self.class.new(header, values_at(*indexes))
    end

    def to_ary
      @data
    end

    def ==(other)
      header = self.header
      other = self.class.coerce(header, other)
      header == other.header &&
      to_ary == other.project(header).to_ary
    end

    def eql?(other)
      header = self.header
      instance_of?(other.class) &&
      header.eql?(other.header) &&
      to_ary.eql?(other.project(header).to_ary)
    end

    def hash
      header.hash ^ to_ary.hash
    end

    def inspect
      to_ary.inspect
    end

  private

    def values_at(*attributes)
      to_ary.values_at(*attributes)
    end

    def self.coerce(header, tuple)
      if tuple.kind_of?(Tuple) && tuple.header.equal?(header)
        tuple
      else
        new(header, tuple)
      end
    end

  end # class Tuple
end # module Veritas
