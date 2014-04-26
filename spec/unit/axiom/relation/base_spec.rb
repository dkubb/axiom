require 'spec_helper'

describe Relation::Base do
  describe '#to_ast' do
    subject(:relation) do
      Relation::Base.new(:users, [[:id, Integer], [:name, String]])
    end

    let(:ast) do
      s(:base, :users,
        s(:header,
          s(:attr, :id, Types::Integer),
          s(:attr, :name, Types::String)
         )
       )
    end

    it 'returns an ast node representing the relation' do
      expect(relation.to_ast).to eql(ast)
    end
  end
end
