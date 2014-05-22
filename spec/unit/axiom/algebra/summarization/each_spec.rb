# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:object)      { described_class.new(operand, operand.project([]), summarizers) }
  let(:operand)     { Relation.new([[:id, Integer]], [[1], [2]])                     }
  let(:summarizers) { { count: ->(acc, _tuple) { acc.to_i + 1 } }                    }
  let(:yields)      { []                                                             }

  it_should_behave_like 'an #each method'

  it 'yields only tuples' do
    subject
    yields.each { |tuple| expect(tuple).to be_instance_of(Tuple) }
  end

  it 'yields only tuples with the expected header' do
    subject
    yields.each { |tuple| expect(tuple.header).to eql(object.header) }
  end

  it 'yields only tuples with the expected data' do
    expect { subject }.to change { yields.dup }
      .from([])
      .to([[2]])
  end
end
