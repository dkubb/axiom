require 'spec_helper'

describe Attribute do
  subject(:attribute) { Attribute.coerce([:id, Integer, {}]) }

  describe '#to_ast' do
    let(:ast) { s(:attr, :id, Types::Integer) }

    it 'returns an ast node representing the tuple' do
      expect(attribute.to_ast).to eql(ast)
    end
  end
end
