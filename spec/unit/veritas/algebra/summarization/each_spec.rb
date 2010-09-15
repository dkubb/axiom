require 'spec_helper'

describe 'Veritas::Algebra::Summarization#each' do
  subject { object.each { |tuple| yields << tuple } }

  let(:klass)       { Algebra::Summarization                               }
  let(:operand)     { Relation.new([ [ :id, Integer ] ], [ [ 1 ], [ 2 ] ]) }
  let(:summarizers) { { :count => lambda { |acc, tuple| acc + 1 } }        }
  let(:object)      { klass.new(operand, operand.project([]), summarizers) }
  let(:yields)      { []                                                   }

  it { should equal(object) }

  it 'yields each tuple' do
    expect { subject }.to change { yields.dup }.from([]).to([ [ 2 ] ])
  end
end
