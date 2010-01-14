module Veritas
  module Algebra
    class Join < Relation
      include Relation::Operation::Combine

      def self.new(left, right)
        if (left.header & right.header).empty?
          raise InvalidHeaderError, "the headers must have common attributes for #{name}.new"
        end

        super
      end

    end # class Join
  end # module Algebra
end # module Veritas

require 'veritas/algebra/join/body'
