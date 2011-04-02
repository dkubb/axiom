require 'spec_helper'

describe Optimizer::Algebra::Extension::UnoptimizedOperand, '#optimize' do
  subject { object.optimize }

  let(:klass)     { Optimizer::Algebra::Extension::UnoptimizedOperand }
  let(:header)    { Relation::Header.new([ [ :id, Integer ] ])        }
  let(:base)      { Relation.new(header, [ [ 1 ] ].each)              }
  let(:attribute) { Attribute::Object.new(:text)                      }
  let(:function)  { lambda { |tuple| 1 }                              }
  let(:operand)   { base.rename({})                                   }
  let(:relation)  { operand.extend { |r| r.add(attribute, function) } }
  let(:object)    { klass.new(relation)                               }

  before do
    object.operation.should be_kind_of(Algebra::Extension)
  end

  it { should_not equal(operand) }

  it { should be_kind_of(Algebra::Extension) }

  its(:operand) { should equal(base) }

  its(:extensions) { should == { attribute => function } }
end
