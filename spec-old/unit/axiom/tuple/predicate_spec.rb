# encoding: utf-8

require 'spec_helper'

describe Tuple, '#predicate' do
  subject { object.predicate }

  context 'when the header is empty' do
    let(:header) { Relation::Header.new            }
    let(:object) { described_class.new(header, []) }

    it_should_behave_like 'an idempotent method'

    it 'returns a tautology' do
      should be(Function::Proposition::Tautology.instance)
    end
  end

  context 'when the header contains one attribute' do
    let(:header) { Relation::Header.coerce([[:id, Integer]]) }
    let(:object) { described_class.new(header, [1])          }

    it_should_behave_like 'an idempotent method'

    it { should be_kind_of(Function) }

    it 'returns an equality match' do
      should eql(header[:id].eq(1))
    end
  end

  context 'when the header contains two or more attribute' do
    let(:header) { Relation::Header.coerce([[:id, Integer], [:name, String]]) }
    let(:object) { described_class.new(header, [1, 'Dan Kubb'])               }

    it_should_behave_like 'an idempotent method'

    it { should be_kind_of(Function) }

    it 'returns a conjunction of equality matches' do
      should eql(header[:id].eq(1).and(header[:name].eq('Dan Kubb')))
    end
  end
end
