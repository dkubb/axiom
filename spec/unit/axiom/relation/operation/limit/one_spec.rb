# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Limit::Methods, '#one' do
  subject { object.one }

  let(:object) { Relation.new(header, body).sort           }
  let(:header) { Relation::Header.coerce([[:id, Integer]]) }

  context 'with a relation having no tuples' do
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
          'one tuple expected, but set contained more than one tuple'
        )
    end

    specify { expect { subject }.to raise_error(SetSizeError) }
  end
end
