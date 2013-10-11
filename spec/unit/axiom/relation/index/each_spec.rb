# encoding: utf-8

require 'spec_helper'

describe Relation::Index, '#each' do
  subject { described_class.new(key, header) << tuple }

  let(:key)    { Relation::Header.coerce([[:id, Integer]])                  }
  let(:header) { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
  let(:tuple)  { Tuple.new(header, [1, 'John Doe'])                         }

  context 'with a block' do
    it 'returns an index' do
      expect(subject.each { }).to be_instance_of(described_class)
    end

    it 'yields each key and tuples' do
      expect { |block| subject.each(&block) }
        .to yield_with_args([[1], Set[tuple]])
    end
  end

  context 'without a block' do
    it 'returns an enumerator' do
      expect(subject.each).to be_instance_of(to_enum.class)
    end

    it 'yields each key and tuples' do
      expect { |block| subject.each.each(&block) }
        .to yield_with_args([[1], Set[tuple]])
    end
  end
end
