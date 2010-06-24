module Veritas
  class Relation
    class Header
      extend Aliasable
      include Enumerable

      inheritable_alias(
        :& => :intersect,
        :| => :union,
        :- => :difference
      )

      def initialize(attributes = [])
        @attributes = attributes.to_ary.map do |attribute|
          Attribute.coerce(attribute)
        end
        @names, @indexes = {}, {}
      end

      def each(&block)
        to_ary.each(&block)
        self
      end

      def index(attribute)
        @indexes[attribute] ||= to_ary.index(self[attribute])
      end

      def [](name)
        @names[name] ||=
          begin
            name = Attribute.name_from(name)
            detect { |attribute| attribute.name == name }
          end
      end

      def project(attributes)
        new(attributes.map { |attribute| self[attribute] })
      end

      def rename(aliases)
        new(map { |attribute| attribute.rename(aliases) })
      end

      def intersect(other)
        new(to_ary & other)
      end

      def union(other)
        new(to_ary | other)
      end

      def difference(other)
        new(to_ary - other)
      end

      def to_ary
        @attributes
      end

      def ==(other)
        to_set == self.class.coerce(other).to_set
      end

      def eql?(other)
        instance_of?(other.class) &&
        to_set == other.to_set
      end

      def hash
        @hash ||= to_ary.hash
      end

      def empty?
        to_ary.empty?
      end

      def inspect
        to_ary.inspect
      end

    private

      def new(attributes)
        self.class.new(attributes)
      end

      def self.coerce(object)
        object.kind_of?(Header) ? object : new(object)
      end

    end # class Header
  end # class Relation
end # module Veritas
