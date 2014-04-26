# encoding: utf-8

require 'spec_helper'

describe Relation::Operation::Sorted, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)     { described_class.new(relation, directions)       }
  let(:relation)   { Relation.new([[:id, Integer]], [[1], [2], [3]]) }
  let(:directions) { [relation[:id].desc]                            }
  let(:yields)     { []                                              }

  it_should_behave_like 'an #each method'

  it 'yields only tuples' do
    subject
    yields.each { |tuple| expect(tuple).to be_instance_of(Tuple) }
  end

  it 'yields only tuples with the expected header' do
    subject
    yields.each { |tuple| expect(tuple.header).to be(object.header) }
  end

  it 'yields only tuples with the expected data in order' do
    expect { subject }.to change { yields.dup }
      .from([])
      .to([[3], [2], [1]])
  end
end
