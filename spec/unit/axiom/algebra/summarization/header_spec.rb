# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#header' do
  subject { object.header }

  let(:operand)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:summarizers) { { test: lambda { |acc, tuple| 1 } }                  }
  let(:object)      { described_class.new(operand, TABLE_DEE, summarizers) }

  it_should_behave_like 'an idempotent method'

  it { should be_instance_of(Relation::Header) }

  it { should == [ [ :test, Object ] ] }
end
