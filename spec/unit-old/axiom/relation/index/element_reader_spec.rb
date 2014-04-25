# encoding: utf-8

require 'spec_helper'

describe Relation::Index, '#[]' do
  subject { object[tuple] }

  let(:object) { described_class.new(key, header)                           }
  let(:key)    { Relation::Header.coerce([[:id, Integer]])                  }
  let(:header) { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:tuple)  { Tuple.new(header, [1, 'John Doe'])                         }

  it 'returns the tuples in the index' do
    object << tuple
    expect(object[tuple]).to eql(Set[tuple])
  end
end
