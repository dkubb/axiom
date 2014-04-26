# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit::Methods, '#one' do
  subject { object.one }

  let(:object) { Relation.new(header, body).sort           }
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }

  context 'with a relation having no tuples without a block' do
    let(:body) { LazyEnumerable.new }

    specify do
      expect { subject }
        .to raise_error(
          NoTuplesError,
          'one tuple expected, but was an empty set'
        )
    end

    specify { expect { subject }.to raise_error(SetSizeError) }
  end

  context 'with a relation having no tuples with a block' do
    subject { object.one { tuple } }

    let(:body)  { LazyEnumerable.new }
    let(:tuple) { double('tuple')    }

    it 'returns the block return value' do
      expect(subject).to be(tuple)
    end

    it 'yields the block' do
      expect { |block| object.one(&block) }.to yield_with_no_args
    end
  end

  context 'with a relation having one tuple' do
    let(:body) { LazyEnumerable.new([[1]]) }

    it { should be_instance_of(Tuple) }

    it 'returns the expected tuple' do
      should == [1]
    end
  end

  context 'with a relation having many tuples' do
    let(:body) { LazyEnumerable.new([[1], [2]]) }

    specify do
      expect { subject }
        .to raise_error(
          ManyTuplesError,
          'one tuple expected, but set contained 2 tuples'
        )
    end

    specify { expect { subject }.to raise_error(SetSizeError) }
  end
end
