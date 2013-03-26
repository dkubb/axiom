# encoding: utf-8

require 'spec_helper'

describe Relation, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object) { described_class.new(header, body)           }
  let(:header) { [ [ :id, Integer ] ]                        }
  let(:body)   { LazyEnumerable.new([ [ 1 ], [ 2 ], [ 2 ] ]) }
  let(:yields) { []                                          }

  before do
    object.should be_instance_of(described_class)
  end

  it_should_behave_like 'an #each method'

  it 'yields only tuples' do
    subject
    yields.each { |tuple| tuple.should be_instance_of(Tuple) }
  end

  it 'yields only tuples with the expected header' do
    subject
    yields.each { |tuple| tuple.header.should be(object.header) }
  end

  it 'yields only tuples with the expected data' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 1 ], [ 2 ] ])
  end
end

describe Relation do
  subject { object.new(header, body) }

  let(:header) { [ [ :id, Integer ] ]          }
  let(:body)   { LazyEnumerable.new([ [ 1 ] ]) }
  let(:object) { described_class               }

  before do
    subject.should be_instance_of(object)
  end

  it { should be_kind_of(Enumerable) }

  it 'case matches Enumerable' do
    (Enumerable === subject).should be(true)
  end
end
