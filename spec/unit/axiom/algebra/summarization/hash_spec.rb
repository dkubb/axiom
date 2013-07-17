# encoding: utf-8

require 'spec_helper'

describe Algebra::Summarization, '#hash' do
  subject { object.hash }

  let(:operand)      { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ])    }
  let(:summarize_by) { operand.project([])                                     }
  let(:summarizers)  { { count: lambda { |acc, tuple| acc.to_i + 1 } }         }
  let(:object)       { described_class.new(operand, summarize_by, summarizers) }

  it_should_behave_like 'a hash method'

  it { should == described_class.hash ^ operand.hash ^ summarize_by.hash ^ summarizers.hash }
end
