module Veritas
  module Algebra
    class Project < Relation
      attr_reader :relation

      def initialize(relation, attributes)
        @relation = relation
        @header   = Header.new(project_attributes(attributes))
      end

    private

      def project_attributes(attributes)
        header = relation.header

        attributes.to_ary.map do |attribute|
          if attribute.kind_of?(Attribute) || attribute.respond_to?(:to_ary)
            header.detect { |attr| attr == attribute }
          else
            attribute = attribute.to_sym
            header.detect { |attr| attr.name == attribute }
          end
        end
      end

    end # class Project
  end # module Algebra
end # module Veritas
