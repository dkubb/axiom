module Veritas
  module Algebra
    class Join < Relation
      include Relation::Operation::Combine

      def self.new(left, right)
        assert_joinable_headers(left, right)
        super
      end

      def self.assert_joinable_headers(left, right)
        if (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must have common attributes for #{name}.new"
        end
      end

      private_class_method :assert_joinable_headers

      def initialize(left, right)
        super
        right_header      = right.header
        @join_header      = left.header  & right_header
        @remainder_header = right_header - @join_header
      end

      def each(&block)
        index = build_index

        left.each do |tuple|
          right_tuples = index[join_tuple(tuple)]
          if right_tuples
            Relation::Operation::Combine.combine_tuples(header, tuple, right_tuples, &block)
          end
        end

        self
      end

    private

      def build_index
        index = {}

        right.each do |tuple|
          (index[join_tuple(tuple)] ||= Set.new) << remainder_tuple(tuple)
        end

        index
      end

      def join_tuple(tuple)
        tuple.project(@join_header)
      end

      def remainder_tuple(tuple)
        tuple.project(@remainder_header)
      end

      module Methods
        extend Aliasable

        inheritable_alias(:+ => :join)

        def join(other, predicate = nil, &block)
          if predicate || block_given?
            theta_join(other, predicate, &block)
          else
            natural_join(other)
          end
        end

      private

        def natural_join(other)
          Join.new(self, other)
        end

        def theta_join(other, *args, &block)
          product(other).restrict(*args.compact, &block)
        end

      end # module Methods

      Relation.class_eval { include Methods }

    end # class Join
  end # module Algebra
end # module Veritas
