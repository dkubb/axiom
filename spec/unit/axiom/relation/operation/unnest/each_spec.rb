# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Unnest, '#each' do
  subject { object }

  let(:object)   { described_class.new(relation, :names)           }
  let(:relation) { Relation.new(header, body).nest(names: [:name]) }
  let(:header)   { [[:id, Integer], [:name, String]]               }
  let(:body)     { [[1, 'John Doe']]                               }

  it_should_behave_like 'an #each method'

  it 'is a command method' do
    expect(subject.each(&EMPTY_PROC)).to be(object)
  end

  it 'yields only tuples' do
    expect { |block| subject.each(&block) }.to yield_with_args(Tuple)
  end

  it 'yields only tuples with the expected header' do
    tuples = []
    subject.each(&tuples.method(:<<))
    expect(tuples.first.header).to eq(header)
  end

  it 'yields only tuples with the expected data' do
    expect { |block| subject.each(&block) }
      .to yield_with_args([1, 'John Doe'])
  end
end
