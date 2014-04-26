require 'spec_helper'

describe Relation::Header do
  subject(:header) { Relation::Header.coerce([[:id, Integer], [:name, String]]) }

  describe '#to_ast' do
    let(:ast) do
      s(:header, s(:attr, :id, Types::Integer), s(:attr, :name, Types::String))
    end

    it 'returns an ast node representing the header' do
      expect(header.to_ast).to eql(ast)
    end
  end
end
