# encoding: utf-8

module Veritas
  module Algebra

    # Rename attributes in the header
    class Rename < Relation
      include Relation::Operation::Unary

      # The aliases for the relation
      #
      # @return [Aliases]
      #
      # @api private
      attr_reader :aliases

      # Initialize a Rename
      #
      # @param [Relation] operand
      #   the relation to rename
      # @param [Hash, Aliases] aliases
      #   the old and new attribute names
      #
      # @return [undefined]
      #
      # @api private
      def initialize(operand, aliases)
        super(operand)
        @aliases    = Aliases.coerce(@header, aliases)
        @header     = @header.rename(@aliases)
        @directions = @directions.rename(@aliases)
      end

      # Iterate over each tuple in the set
      #
      # @example
      #   rename = Rename.new(operand, aliases)
      #   rename.each { |tuple| ... }
      #
      # @yield [tuple]
      #
      # @yieldparam [Tuple] tuple
      #   each tuple in the set
      #
      # @return [self]
      #
      # @api public
      def each
        return to_enum unless block_given?
        operand.each { |operand_tuple| yield Tuple.new(header, operand_tuple.to_ary) }
        self
      end

      # Compare the Rename with other relation for equality
      #
      # @example
      #   rename.eql?(other)  # => true or false
      #
      # @param [Relation] other
      #   the other relation to compare with
      #
      # @return [Boolean]
      #
      # @api public
      def eql?(other)
        super && aliases.eql?(other.aliases)
      end

      # Return the hash of the rename
      #
      # @example
      #   hash = rename.hash
      #
      # @return [Fixnum]
      #
      # @api public
      def hash
        super ^ aliases.hash
      end

      module Methods

        # Return a relation with the header renamed
        #
        # @example
        #   rename = relation.rename(a: :b, c: :d)
        #
        # @param [Hash, Aliases] aliases
        #   the old and new attribute names
        #
        # @return [Rename]
        #
        # @api public
        def rename(aliases)
          Rename.new(self, aliases)
        end

      end # module Methods

      Relation.class_eval { include Methods }

      memoize :hash

    end # class Rename
  end # module Algebra
end # module Veritas
