module Veritas
  module Algebra
    class Rename
      class Aliases
        extend Aliasable
        include Immutable

        inheritable_alias(:| => :union)

        def initialize(aliases)
          @aliases = Immutable.freeze_value(aliases.to_hash)
        end

        def [](attribute)
          @aliases.fetch(attribute, attribute)
        end

        def union(other)
          other_aliases = other.to_hash.dup
          inverted      = other_aliases.invert

          @aliases.each do |old_attribute, new_attribute|
            old_attribute = inverted.fetch(old_attribute, old_attribute)

            if old_attribute.eql?(new_attribute)
              other_aliases.delete(new_attribute)
            else
              other_aliases[old_attribute] = new_attribute
            end
          end

          self.class.new(other_aliases)
        end

        def empty?
          @aliases.empty?
        end

        def ==(other)
          (kind_of?(other.class) || other.kind_of?(self.class)) &&
          to_hash == other.to_hash
        end

        def eql?(other)
          instance_of?(other.class) &&
          to_hash.eql?(other.to_hash)
        end

        def hash
          @aliases.hash
        end

        def to_hash
          @aliases
        end

        def self.coerce(attributes, aliases)
          return aliases if aliases.kind_of?(Aliases)
          renames = aliases.map do |old_attr, new_attr|
            coerce_alias_pair(attributes, old_attr, new_attr)
          end
          new(Hash[renames].freeze)
        end

        def self.coerce_alias_pair(attributes, old_attr, new_attr)
          old_attr = attributes[old_attr]      if old_attr.kind_of?(Symbol)
          new_attr = old_attr.rename(new_attr) if new_attr.kind_of?(Symbol)
          [ old_attr, new_attr ]
        end

        private_class_method :coerce_alias_pair

      end # class Aliases
    end # class Rename
  end # module Algebra
end # module Veritas
