require 'spec_helper'

describe Tuple do
  subject(:tuple) { Tuple.coerce([[:id, Integer], [:name, String]], data) }

  let(:data) { [[1, 'Jane'], [2, 'John']] }

  describe '#to_ast' do
    let(:ast) { s(:tuple, s(:data, data)) }

    it 'returns an ast node representing the tuple' do
      pending 'not implemented yet'

      expect(tuple.to_ast).to eql(ast)
    end
  end
end
