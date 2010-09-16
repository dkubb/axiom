require 'spec_helper'

describe 'Veritas::Optimizer::Algebra::Summarization::UnoptimizedOperand#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Algebra::Summarization::UnoptimizedOperand         }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ])                    }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)                          }
  let(:attribute) { Attribute::Object.new(:text)                                  }
  let(:function)  { lambda { |tuple, acc| 1 }                                     }
  let(:operand)   { base.project(header)                                          }
  let(:relation)  { operand.summarize(operand) { |r| r.add(attribute, function) } }
  let(:object)    { klass.new(relation)                                           }

  before do
    object.operation.should be_kind_of(Algebra::Summarization)
  end

  it { should_not equal(operand) }

  it { should eql(base.summarize(base) { |r| r.add(attribute, function) }) }

  its(:summarizers) { should == { attribute => function } }
end
