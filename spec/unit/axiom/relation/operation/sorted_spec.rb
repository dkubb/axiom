require "spec_helper"

describe Relation::Operation::Sorted do
  subject(:sorted) do
    Relation::Operation::Sorted.new(relation, [:id, :name])
  end

  let(:relation) do
    Relation::Base.new(:users, [[:id, Integer], [:name, String]])
  end

  describe '#to_ast' do
    let(:ast) do
      s(:sorted,
        relation.to_ast,
        s(:directions, s(:direction, :id, :asc), s(:direction, :name, :asc))
       )
    end

    it 'returns an ast node representing sorted relation' do
      expect(sorted.to_ast).to eql(ast)
    end
  end
end
