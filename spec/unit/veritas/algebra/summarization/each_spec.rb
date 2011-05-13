# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:operand)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])           }
  let(:summarizers) { { :count => lambda { |acc, tuple| acc.to_i + 1 } }             }
  let(:object)      { described_class.new(operand, operand.project([]), summarizers) }
  let(:yields)      { []                                                             }

  it_should_behave_like 'an #each method'

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.
      from([]).
      to([ [ 2 ] ])
  end
end
